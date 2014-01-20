class Score
  include ActiveModel::SerializerSupport
  include CouchRest::Model::Embeddable
  
  property :name,      String
  property :value,     Integer
  
  def id
    "#{name}_#{base_doc.id}"
  end
end