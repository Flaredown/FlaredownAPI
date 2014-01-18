class Score
  include ActiveModel::SerializerSupport
  include CouchRest::Model::Embeddable
  
  property :id,      String
  property :value,     Integer
end