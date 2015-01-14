class UserSymptom < ActiveRecord::Base

  has_paper_trail

  belongs_to :user, counter_cache: :symptoms_count
  belongs_to :symptom

end
