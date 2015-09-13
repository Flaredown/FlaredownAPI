class EntryTreatment
  include ActiveModel::SerializerSupport
  include Mongoid::Document

  embedded_in :entry

  field :name,      type: String
  field :quantity,  type: Float
  field :unit,      type: String
  field :repetition,type: Integer

  def taken?
    return false if quantity == -1.0
    quantity.present?
  end

  def id
    "#{name}_#{quantity}_#{unit}_#{repetition}_#{entry.id}"
  end
end