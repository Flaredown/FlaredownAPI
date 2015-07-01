module TreatmentsCatalog
  extend ActiveSupport::Concern

  def treatments_responses
    treatments
  end

  def filled_treatments_entry?
    true # we don't care if it's complete or not for treatments
  end

  def complete_treatments_entry?
    filled_treatments_entry?
  end
end