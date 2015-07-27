class EntryTreatment
  include ActiveModel::SerializerSupport
  include CouchRest::Model::Embeddable

  property :name,      String
  property :quantity,  Float
  property :unit,      String
  property :repetition,Integer

  def taken?
    return false if quantity == -1.0
    quantity.present?
  end

  def id
    "#{name}_#{quantity}_#{unit}_#{repetition}_#{base_doc.id}"
  end
end