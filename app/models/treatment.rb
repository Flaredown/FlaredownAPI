class Treatment
  include ActiveModel::SerializerSupport
  include CouchRest::Model::Embeddable

  property :name,      String
  property :quantity,  Integer
  property :unit,      String

  def id
    "#{name}_#{base_doc.id}"
  end
end