class Question
  include CouchRest::Model::Embeddable
  include ActiveModel::Validations
  
  property :name,      String
  property :response
  
end