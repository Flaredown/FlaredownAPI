class Score
  include CouchRest::Model::Embeddable
  
  property :name,      String
  property :value,     Integer
end