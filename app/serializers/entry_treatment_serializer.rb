class EntryTreatmentSerializer < ActiveModel::Serializer
  attributes :id,
    :name,
    :quantity,
    :unit

  def id; object.id.to_s; end
end