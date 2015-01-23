# Clear it out first

REDIS.flushdb
Entry.all.each{|e| e.destroy if %w( 1 12 ).include?(e.user_id) } # wipe out test@test.com and graham@flaredown.com entries
User.all.each{|u| u.destroy}
UserSymptom.all.each{|us| us.destroy}
UserTreatment.all.each{|ut| ut.destroy}
ActiveRecord::Base.connection.reset_pk_sequence!("users")

PaperTrail::Version.all.each{|v| v.destroy}

### GO BACK 1 YEAR FOR PROPER TIMELINE ###
Timecop.freeze(1.year.ago)

### SETUP USERS WITH THEIR TRACKABLES ###

### TEST@TEST.COM ###
#####################
u=User.create(id: 1, email: "test@test.com", password: "testing123", password_confirmation: "testing123")
u.user_conditions.activate Condition.create_with(locale: "en").find_or_create_by(name: "Crohn's Disease")

### SYMPTOMS
["droopy lips", "fat toes", "slippery tongue"].each do |name|
  s = Symptom.create_with(locale: "en").find_or_create_by(name: name)
  u.user_symptoms.activate s
end
["buck-toothedness"].each do |name|
  s = Symptom.create_with(locale: "en").find_or_create_by(name: name)
  u.user_symptoms.activate s
  u.user_symptoms.deactivate s
end

### TREATMENTS
[
  {name: "Tickles", quantity: "1.0", unit: "session"},
  {name: "Laughing Gas", quantity: "10.5", unit: "cc"}
].each do |treatment|
  t = Treatment.create_with(locale: "en", quantity: treatment[:quantity], unit: treatment[:unit]).find_or_create_by(name: treatment[:name])
  u.user_treatments.activate t
end
[
  {name: "Funny Bone Electroshock", quantity: "15.0", unit: "repetition"},
  {name: "Toe Stubbing", quantity: "1.0", unit: "time"}
].each do |treatment|
  t = Treatment.create_with(locale: "en", quantity: treatment[:quantity], unit: treatment[:unit]).find_or_create_by(name: treatment[:name])
  u.user_treatments.activate t
  u.user_treatments.deactivate t
end

### GRAHAM@FLAREDOWN.COM ###
############################

graham=User.create(id: 12, email: "graham@flaredown.com", password: "testing123", password_confirmation: "testing123")
graham.user_conditions.activate Condition.create_with(locale: "en").find_or_create_by(name: "allergies")

# Add symptom names from :hbi_and_symptoms_entry
["sneezing", "runny nose", "congestion", "itchy throat"].each do |name|
  s = Symptom.create_with(locale: "en").find_or_create_by(name: name)
  graham.user_symptoms.activate s
end


### COLIN@FLAREDOWN.COM ###
###########################
colin=User.create(id: 11, email: "colin@flaredown.com", password: "testing123", password_confirmation: "testing123", created_at: 1.year.ago.to_time)
["pain", "fatigue", "digestive", "lightheadedness", "anxiety"].each do |name|
    s = Symptom.create_with(locale: "en").find_or_create_by(name: name)
    colin.user_symptoms.activate s
end

### Create a new audit for each user after they've added their trackables ###
[u, graham, colin].each do |user|
  at = Date.today+1.day # 1 year ago + 1 day
  Timecop.freeze(at){user.create_audit}
end

### Back to NOW ###
Timecop.return