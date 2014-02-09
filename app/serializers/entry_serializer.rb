class EntrySerializer < ActiveModel::Serializer
  has_many :scores
  has_many :questions
  has_many :responses
  # :treatments,
  # :catalogs
   
  attributes :id,
    :date
end