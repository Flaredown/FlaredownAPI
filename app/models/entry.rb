class Entry < CouchRest::Model::Base
  include ActiveModel::SerializerSupport
  AVAILABLE_CATALOGS = %w( cdai )
  
  @queue = :entries
  cattr_accessor(:question_names) {[]}
  
  def initialize(attributes={}, options={})
    super(attributes, options)
    include_catalogs
  end
  
  before_save :include_catalogs
  def include_catalogs
    if catalogs.present?
      loadable_catalogs = catalogs.select{|catalog| AVAILABLE_CATALOGS.include?(catalog)}
      loadable_catalogs.each{|catalog| self.class_eval { include "#{catalog}_catalog".classify.constantize }}
    end
  end
  
  belongs_to :user
  
  property :date,       Date
  property :catalogs,   [String]

  property :questions,  Question,  :array => true
  property :treatments, Treatment, :array => true
  property :scores,     Score,     :array => true

  timestamps!

  design do
    view :by_date
    view :by_user_id
  end
  
  def method_missing(name, *args)
    if self.question_names.include?(name)
      question = questions.select{|q| q.name.to_sym == name}.first
      return question.response if question
    else
      super(name, *args)
    end
  end

end