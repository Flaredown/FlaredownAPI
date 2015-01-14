# Clear it out first

REDIS.flushdb
Entry.all.each{|e| e.destroy if e.user_id == "1"} # wipe out test@test.com entries
User.all.each{|u| u.destroy}
UserSymptom.all.each{|us| us.destroy}
UserTreatment.all.each{|ut| ut.destroy}
ActiveRecord::Base.connection.reset_pk_sequence!("users")

PaperTrail.enabled = false
PaperTrail::Version.all.each{|v| v.destroy}

u=User.create(id: 1, email: "test@test.com", password: "testing123", password_confirmation: "testing123")
u.activate_condition Condition.create_with(locale: "en").find_or_create_by(name: "Crohn's Disease")

### SYMPTOMS
["droopy lips", "fat toes", "slippery tongue"].each do |name|
  s = Symptom.create_with(locale: "en").find_or_create_by(name: name)
  u.activate_symptom s
end

### TREATMENTS
[
  {name: "Tickles", quantity: "1.0", unit: "session"},
  {name: "Laughing Gas", quantity: "10.5", unit: "cc"}
].each do |treatment|
  t = Treatment.create_with(locale: "en", quantity: treatment[:quantity], unit: treatment[:unit]).find_or_create_by(name: treatment[:name])
  u.activate_treatment t
end

# Add entries for test user
200.times do |n|
  FactoryGirl.create :hbi_and_symptoms_entry, user: u, date: Date.today-n.days-5
end

# Clear Resque because these are already processed
Resque.queues.each{|q| Resque.redis.del "queue:#{q}" }

# Add Colin and his symptoms (entries sold separately)
colin=User.create(id: 11, email: "colin@flaredown.com", password: "testing123", password_confirmation: "testing123")
["pain", "fatigue", "digestive", "lightheadedness", "anxiety"].each do |name|
    s = Symptom.create_with(locale: "en").find_or_create_by(name: name)
    colin.activate_symptom s
end

