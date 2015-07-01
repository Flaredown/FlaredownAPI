class EntryTreatment
  include ActiveModel::SerializerSupport
  include CouchRest::Model::Embeddable

  property :name,      String
  property :quantity,  Float
  property :unit,      String
  property :repetition,Integer

  def taken?
    quantity.present?
  end

  def id
    "#{name}_#{quantity}_#{unit}_#{repetition}_#{base_doc.id}"
  end
end