class Treatment
  include CouchRest::Model::Embeddable
  include Enumerable

  property :name,      String
end