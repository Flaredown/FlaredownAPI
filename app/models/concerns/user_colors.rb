module UserColors
  extend ActiveSupport::Concern
  include Colorable

  def symptom_colors
    symptom_colorables = user_symptoms.map do |assoc|
      symptom = assoc.symptom
      {name: "symptoms_#{symptom.name}", date: assoc.created_at, active: true } # active_symptoms.include?(symptom.id.to_s)
    end

    catalog_colorables = user_conditions.reduce([]) do |accum,assoc|
      condition = assoc.condition
      catalog   = CATALOG_CONDITIONS[condition.name]

      if catalog
        "#{catalog.capitalize}Catalog".constantize.const_get("SCORE_COMPONENTS").map do |component|
          accum << {name: "#{catalog}_#{component}", date: assoc.created_at, active: true } # active_conditions.include?(condition.id.to_s)
        end
      end
      accum
    end

    colors_for((symptom_colorables|catalog_colorables), palette: :symptoms)
  end

  def treatment_colors
    colorables = user_treatments.map do |assoc|
      treatment = assoc.treatment
      {name: "treatments_#{treatment.name}", date: assoc.created_at, active: true } # active_treatments.include?(treatment.id.to_s)
    end
    colors_for(colorables, palette: :treatments)
  end

end