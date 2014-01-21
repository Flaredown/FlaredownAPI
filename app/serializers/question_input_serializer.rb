class QuestionInputSerializer < ActiveModel::Serializer
  attributes :id,
    :value,
    :label,
    :meta_label,
    :helper
end