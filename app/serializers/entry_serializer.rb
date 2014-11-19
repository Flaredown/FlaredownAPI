class EntrySerializer < ActiveModel::Serializer
  # has_many :scores
  has_many :responses
  # :treatments,

  attributes :id,
    :date,
    :catalog_definitions,
    :catalogs,
    :responses

  def serializable_hash
    all = super
    attrs_to_serialize = filtered_attributes(all.keys, scope)
    all.slice(*attrs_to_serialize)
  end

  def filtered_attributes(keys,scope)
    if scope == :new
      %i( id date catalogs catalog_definitions )
    else
      keys - %i( catalog_definitions )
    end
  end

end