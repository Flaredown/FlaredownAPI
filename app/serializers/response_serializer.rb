class ResponseSerializer < ActiveModel::Serializer
  attributes :id,
    :name,
    :value,
    :catalog
end