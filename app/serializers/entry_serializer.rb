class EntrySerializer < ActiveModel::Serializer
  embed :ids, include: false
  
  attributes :id,
    :date,
    :scores,
    :questions,
    :responses,
    :treatments,
    :catalogs
    
    

    def date
      DateTime.strptime(object.date.to_s, "%s")
    end
    
end