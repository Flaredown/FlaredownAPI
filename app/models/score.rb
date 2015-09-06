class Score
  include ActiveModel::SerializerSupport
  include Mongoid::Document

  embedded_in :entry

  field :name, type: String
  field :value, type: Float

  def id
    "#{name}_#{entry.id}"
  end
end