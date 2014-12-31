# Clear it out first
REDIS.flushdb
Entry.all.each{|e| e.destroy}
User.all.each{|u| u.destroy}
ActiveRecord::Base.connection.reset_pk_sequence!("users")
# old_user=User.find_by_email("test@test.com")
# old_user.delete if old_user

u=User.create(id: 1, email: "test@test.com", password: "testing123", password_confirmation: "testing123", gender: "male", weight: 145, catalogs: ["hbi"])
colin=User.create(id: 11, email: "colin@flaredown.com", password: "testing123", password_confirmation: "testing123", gender: "male", weight: 135, catalogs: ["symptoms"])

# Add symptom names from :hbi_and_symptoms_entry
["droopy lips", "fat toes", "slippery tongue"].each do |name|
  s = u.symptoms.create name: name, language: "en"
  u.active_symptoms << s.id
end

500.times do |n|
  FactoryGirl.create :hbi_and_symptoms_entry, user: u, date: Date.today-n.days
end

# Add symptoms for user colin
["pain", "fatigue", "digestive", "lightheadedness", "anxiety"].each do |name|
    s = colin.symptoms.create name: name, language: "en"
    colin.active_symptoms << s.id
end
