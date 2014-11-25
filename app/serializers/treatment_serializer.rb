class TreatmentSerializer < ActiveModel::Serializer
  attributes :id,
    :name,
    :quantity,
    :unit
end