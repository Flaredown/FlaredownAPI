class Treatment
  include CouchRest::Model::Embeddable
  
  property :name,      String
end