class Entry < CouchRest::Model::Base
  include ActiveModel::SerializerSupport
  include CatalogScore
  include SymptomsCatalog
  include EntryAuditing
  AVAILABLE_CATALOGS = %w( hbi rapid3 )

  @queue = :entries

  def initialize(attributes={}, options={})
    super(attributes, options)
    include_catalogs
  end

  before_create :include_catalogs
  before_save   :include_catalogs
  after_save :enqueue

  belongs_to :user

  property :date,       Date
  property :catalogs,   [String], default: []
  property :conditions, [String], default: []

  # TODO cleanup [Thing] vs array: true format
  property :responses,  Response,  :array => true
  property :treatments, EntryTreatment, :array => true
  property :notes,      String
  property :triggers,   [String]

  property :scores,     Score,     :array => true

  attr_accessor :user_audit_version

  timestamps!

  design do
    view :by_date
    view :by_user_id
    view :by_date_and_user_id
  end

  def user
    User.find_by(id: user_id)
  end

  def catalog_definitions
    (self.catalogs | ["symptoms"]).reduce({}) do |definitions,catalog|
      _module = "#{catalog.capitalize}Catalog".constantize
      definitions[catalog.to_sym] = (catalog == "symptoms") ? symptoms_definition : _module.const_get("DEFINITION")
      definitions
    end
  end

  # Collect all question names from included catalogs
  #
  # Returns array of question name symbols
  def question_names
    self.catalogs.reduce([]) do |names, catalog|
      questions = "#{catalog.capitalize}Catalog".constantize.const_get("QUESTIONS")
      namespaced_questions = questions.map{|question| "#{catalog}_#{question}".to_sym }

      names + namespaced_questions
    end
  end

  def enqueue
    Resque.enqueue(Entry, self.id)
  end

  def complete?
    catalogs.each{|catalog| return false unless self.send("complete_#{catalog}_entry?")}
    true
  end

  def self.perform(entry_id, notify=true)
    entry = Entry.find(entry_id)

    (entry.catalogs | ["symptoms"]).each do |catalog|
      entry.send("save_score", catalog)
      entry.save_without_processing
    end

    entry.user.notify!("entry_processed", {entry_date: entry.date}) if entry.complete? and notify
    true
  end

  def save_without_processing
    Entry.skip_callback(:save, :after, :enqueue)
    save
    Entry.set_callback(:save, :after, :enqueue)
  end

  private

  def include_catalogs
    if catalogs.present?
      loadable_catalogs = catalogs.select{|catalog| AVAILABLE_CATALOGS.include?(catalog)}
      loadable_catalogs.each{|catalog| self.class_eval { include "#{catalog}_catalog".classify.constantize }}
    end
  end

  def method_missing(name, *args)

    # Lookup Score for any _score methods from included catalogs
    if match = name.to_s.match(/(\w+)_score\Z/)
      self.scores.detect{|s| s[:name] == match[1] }.value

    # Lookup Response.value base on {catalog}_{question_name} format
    elsif question_names.include?(name)
      catalog, question_name = name.to_s.match(/(\w+?)_(.*)\Z/).to_a[1..2]
      response = responses.detect{|r| r.catalog == catalog and r.name == question_name}

      return response.value if response
    else
      super(name, *args)
    end

  end

end