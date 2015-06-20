module UserColors
  extend ActiveSupport::Concern
  include Colorable

  def trackable_colors
    colors_for(condition_colorables|symptom_colorables|catalog_colorables|treatment_colorables, palette: :flaredown)
  end

  def symptom_colorables
    user_symptoms.map do |assoc|
      symptom = assoc.symptom
      {name: "symptoms_#{symptom.name}", date: assoc.created_at, active: true } # active_symptoms.include?(symptom.id.to_s)
    end
  end

  def condition_colorables
    user_conditions.map do |assoc|
      condition = assoc.condition
      {name: "conditions_#{condition.name}", date: assoc.created_at, active: true }
    end
  end

  def catalog_colorables
    user_conditions.reduce([]) do |accum,assoc|
      condition = assoc.condition
      catalog   = CATALOG_CONDITIONS[condition.name]

      if catalog
        "#{catalog.capitalize}Catalog".constantize.const_get("SCORE_COMPONENTS").map do |component|
          accum << {name: "#{catalog}_#{component}", date: assoc.created_at, active: true } # active_conditions.include?(condition.id.to_s)
        end
      end
      accum
    end
  end

  def treatment_colorables
    user_treatments.map do |assoc|
      treatment = assoc.treatment
      {name: "treatments_#{treatment.name}", date: assoc.created_at, active: true } # active_treatments.include?(treatment.id.to_s)
    end
  end

end