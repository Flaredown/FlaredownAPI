class EntryTreatment
  include ActiveModel::SerializerSupport
  include CouchRest::Model::Embeddable

  property :name,      String
  property :quantity,  Float
  property :unit,      String

  def id
    "#{name}_#{quantity}_#{unit}_#{base_doc.id}"
  end
end