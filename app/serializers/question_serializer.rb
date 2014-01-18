class QuestionSerializer < ActiveModel::Serializer
  attributes :id,
    :catalog,
    :name,
    :kind,
    :group,
    :section,
    :input_options

  def input_options
    object.options
  end
end