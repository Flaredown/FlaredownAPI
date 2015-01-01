# Clear it out first
REDIS.flushdb
Entry.all.each{|e| e.destroy if e.user_id == "1"} # wipe out test@test.com entries
User.all.each{|u| u.destroy}
ActiveRecord::Base.connection.reset_pk_sequence!("users")

u=User.create(id: 1, email: "test@test.com", password: "testing123", password_confirmation: "testing123", gender: "male", weight: 145, catalogs: ["hbi"])

# Add symptom names from :hbi_and_symptoms_entry
active_symptoms = []
["droopy lips", "fat toes", "slippery tongue"].each do |name|
  s = Symptom.create_with(language: "en").find_or_create_by(name: name)
  active_symptoms << s.id
end
u.update_attribute(:active_symptoms, active_symptoms)

# Add entries for test user
200.times do |n|
  FactoryGirl.create :hbi_and_symptoms_entry, user: u, date: Date.today-n.days
end

# Add Colin and his symptoms (entries sold separately)
active_symptoms = []
colin=User.create(id: 11, email: "colin@flaredown.com", password: "testing123", password_confirmation: "testing123", gender: "male", weight: 135, catalogs: ["symptoms"])
["pain", "fatigue", "digestive", "lightheadedness", "anxiety"].each do |name|
    s = Symptom.create_with(language: "en").find_or_create_by(name: name)
    active_symptoms << s.id
end
colin.update_attribute(:active_symptoms, active_symptoms)