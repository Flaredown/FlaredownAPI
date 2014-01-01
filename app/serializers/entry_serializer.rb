class EntrySerializer < ActiveModel::Serializer  
  root false
  embed :ids, include: false
  
  attributes :id,
    :date,
    :score
    
end