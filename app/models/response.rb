class Response
  include CouchRest::Model::Embeddable
  include ActiveModel::Validations
  include ActiveModel::SerializerSupport
  
  property :id,      String
  property :value
end