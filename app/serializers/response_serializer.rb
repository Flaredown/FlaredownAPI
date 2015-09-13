class ResponseSerializer < ActiveModel::Serializer
  attributes :id,
    :name,
    :value,
    :catalog

  def id; object.id.to_s; end
end