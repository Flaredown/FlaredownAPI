class Response
  include CouchRest::Model::Embeddable
  include ActiveModel::Validations
  
  property :name,      String
  property :value
end