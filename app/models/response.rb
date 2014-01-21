class Response
  include CouchRest::Model::Embeddable
  include ActiveModel::Validations
  include ActiveModel::SerializerSupport
  
  property :name, String
  property :value, Integer
  
  def question
    Question.find_by_name(name)
  end
  def id
    "#{name}_#{base_doc.id}"
  end
  
end