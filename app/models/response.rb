class Response
  include Mongoid::Document
  include ActiveModel::Validations
  include ActiveModel::SerializerSupport

  embedded_in :entry

  field :name, type: String
  field :value, type: Float
  field :catalog, type: String

  def id
    "#{catalog}_#{name}_#{entry.id}"
  end

end