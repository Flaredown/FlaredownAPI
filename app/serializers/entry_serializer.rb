class EntrySerializer < ActiveModel::Serializer

  has_many :responses, serializer: ResponseSerializer
  # has_many :scores, serializer: ScoreSerializer
  has_many :treatments, serializer: EntryTreatmentSerializer
  # has_many :tags, serializer: TagSerializer

  attributes :id,
    :date,
    :catalog_definitions,
    :catalogs,
    :notes,
    :complete,
    :tags,
    :created_at,
    :updated_at,
    :just_created

  def id; object.id.to_s; end
  def just_created; scope == :new ? true : false  end
  def catalogs;     object.catalogs | ["symptoms"]; end
  def date;         object.date.strftime("%b-%d-%Y"); end
  def complete;     object.complete?; end

  # Used for overriding returned keys using #filtered_attributes
  def serializable_hash
    all = super
    attrs_to_serialize = filtered_attributes(all.keys, scope)
    all.slice(*attrs_to_serialize)
  end

  # Defines keys to return based on scope
  #
  # keys - keys to be filtered (all the keys)
  # scope - scope parameter passed to serializer on instantiation
  #
  # Returns array of symbols
  def filtered_attributes(keys,scope)
    case scope
    when :new
      %i( id date catalogs catalog_definitions treatments complete just_created )
    when :existing
      keys
    else
      keys - %i( catalog_definitions )
    end
  end

end