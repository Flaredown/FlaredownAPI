# Clear it out first
REDIS.flushdb
Entry.all.each{|e| e.destroy if e.user_id == "1"} # wipe out test@test.com entries
User.all.each{|u| u.destroy}
UserSymptom.all.each{|us| us.destroy}
ActiveRecord::Base.connection.reset_pk_sequence!("users")

u=User.create(id: 1, email: "test@test.com", password: "testing123", password_confirmation: "testing123", catalogs: ["hbi"])

# Add symptom names from :hbi_and_symptoms_entry
["droopy lips", "fat toes", "slippery tongue"].each do |name|
  s = Symptom.create_with(locale: "en").find_or_create_by(name: name)
  u.activate_symptom s
end

# Add entries for test user
200.times do |n|
  FactoryGirl.create :hbi_and_symptoms_entry, user: u, date: Date.today-n.days, treatments: [FactoryGirl.build(:treatment), FactoryGirl.build(:treatment, {name: "Laughing Gas", quantity: "10.5", unit: "cc"})]
end

# Add Colin and his symptoms (entries sold separately)
colin=User.create(id: 11, email: "colin@flaredown.com", password: "testing123", password_confirmation: "testing123", catalogs: ["symptoms"])
["pain", "fatigue", "digestive", "lightheadedness", "anxiety"].each do |name|
    s = Symptom.create_with(locale: "en").find_or_create_by(name: name)
    u.activate_symptom s
end

Resque.queues.each{|q| Resque.redis.del "queue:#{q}" }