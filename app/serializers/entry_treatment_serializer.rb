class EntryTreatmentSerializer < ActiveModel::Serializer
  attributes :id,
    :name,
    :quantity,
    :unit
end