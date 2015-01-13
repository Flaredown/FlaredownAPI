class UserSymptom < ActiveRecord::Base

  belongs_to :user, counter_cache: :symptoms_count
  belongs_to :symptom

end
