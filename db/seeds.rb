# Clear it out first
REDIS.flushdb
Entry.all.each{|e| e.destroy}
User.all.each{|u| u.destroy}
ActiveRecord::Base.connection.reset_pk_sequence!("users")

u=User.create(id: 1, email: "test@test.com", password: "testing123", password_confirmation: "testing123", gender: "male", weight: 145, catalogs: ["hbi"])

# Add symptom names from :hbi_and_symptoms_entry
["droopy lips", "fat toes", "slippery tongue"].each do |name|
  s = u.symptoms.create name: name, language: "en"
  u.active_symptoms << s.id
end

# Add entries for test user
200.times do |n|
  FactoryGirl.create :hbi_and_symptoms_entry, user: u, date: Date.today-n.days
end

# Add Colin and his symptoms (entries sold separately)
colin=User.create(id: 11, email: "colin@flaredown.com", password: "testing123", password_confirmation: "testing123", gender: "male", weight: 135, catalogs: ["symptoms"])
["pain", "fatigue", "digestive", "lightheadedness", "anxiety"].each do |name|
    s = colin.symptoms.create name: name, language: "en"
    colin.active_symptoms << s.id
end
