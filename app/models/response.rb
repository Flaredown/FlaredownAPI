class Response
  include CouchRest::Model::Embeddable
  include ActiveModel::Validations
  include ActiveModel::SerializerSupport

  property :name, String
  property :value, Float
  property :catalog, String

  def id
    "#{catalog}_#{name}_#{base_doc.id}"
  end

end