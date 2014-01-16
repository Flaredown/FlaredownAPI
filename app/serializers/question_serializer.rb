class QuestionSerializer < ActiveModel::Serializer
  embed :ids, include: false
  
  attributes :id,
    :catalog,
    :name,
    :kind,
    :group,
    :section,
    :options

end