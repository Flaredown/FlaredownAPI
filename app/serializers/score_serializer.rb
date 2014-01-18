class ScoreSerializer < ActiveModel::Serializer  
  attributes :id,
    :uuid,
    :value
    
  def uuid
    "#{object.id}_#{object.base_doc.id}"
  end
end