class EntrySerializer < ActiveModel::Serializer
  has_many :scores
  has_many :questions, embed: :ids, include: true
  has_many :responses
  # :treatments,
  # :catalogs
   
  attributes :id,
    :date
    
end