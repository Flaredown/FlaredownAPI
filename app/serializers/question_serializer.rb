class QuestionSerializer < ActiveModel::Serializer
  attributes :id,
    :catalog,
    :name,
    :localized_name,
    :kind,
    :group,
    :section,
    :input_options

  def input_options
    if object.options
      object.options.each do |option|
        option[:id] = "#{object.name}_#{option[:value]}"
      end
    end
    
    object.options
  end
end