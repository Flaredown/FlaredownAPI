class EntrySerializer < ActiveModel::Serializer

  attributes :id,
    :date,
    :catalog_definitions,
    :catalogs,
    :responses,
    :scores,
    :treatments,
    :notes,
    :triggers

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
    if scope == :new
      %i( id date catalogs catalog_definitions )
    else
      keys - %i( catalog_definitions )
    end
  end

end