class ScoreSerializer < ActiveModel::Serializer
  attributes :id,
    :name,
    :value

  def id; object.id.to_s; end
end