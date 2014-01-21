class QuestionSerializer < ActiveModel::Serializer
  has_many :inputs, embed: :ids, include: true
  
  attributes :id,
    :catalog,
    :name,
    :localized_name,
    :kind,
    :group,
    :section
end