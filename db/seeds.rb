# Clear it out first

REDIS.flushdb
# Entry.all.each{|e| e.destroy if %w( 1 2 3 4 11 12 ).include?(e.user_id) } # wipe out test*@flaredown.com and graham@flaredown.com entries
Entry.all.each{|e| e.destroy } # wipe out test*@flaredown.com and graham@flaredown.com entries
User.all.each{|u| u.destroy}

UserSymptom.all.each{|us| us.destroy}
Symptom.all.each{|s| s.destroy}

UserTreatment.all.each{|ut| ut.destroy}
Treatment.all.each{|t| t.destroy}

UserCondition.all.each{|uc| uc.destroy}
Condition.all.each{|c| c.destroy}

ActiveRecord::Base.connection.reset_pk_sequence!("users")

PaperTrail::Version.all.each{|v| v.destroy}

### GO BACK 1 YEAR FOR PROPER TIMELINE ###
Timecop.freeze(1.year.ago)

### SETUP USERS WITH THEIR TRACKABLES ###

### TEST@FLAREDOWN.COM ###
#####################

### Symptoms, condition and treatments and entries
t1=User.create(id: 1, email: "test@flaredown.com",  password: "testing123", password_confirmation: "testing123")
### Symptoms, condition and treatments and *no* entries
t2=User.create(id: 2, email: "test2@flaredown.com", password: "testing123", password_confirmation: "testing123")
### Blank
t3=User.create(id: 3, email: "test3@flaredown.com", password: "testing123", password_confirmation: "testing123")
### Blank
t4=User.create(id: 4, email: "test4@flaredown.com", password: "testing123", password_confirmation: "testing123")
### VIDEO user
t5=User.create(id: 5, email: "video@flaredown.com", password: "testing123", password_confirmation: "testing123")

[t1,t2].each do |user|
  user.user_conditions.activate Condition.create_with(locale: "en").find_or_create_by(name: "Crohn's Disease")
end

### SYMPTOMS
["droopy lips", "fat toes", "slippery tongue"].each do |name|
  s = Symptom.create_with(locale: "en").find_or_create_by(name: name)
  [t1,t2].each do |user|
    user.user_symptoms.activate s
  end
end
["buck-toothedness"].each do |name|
  s = Symptom.create_with(locale: "en").find_or_create_by(name: name)
  [t1,t2].each do |user|
    user.user_symptoms.activate s
    user.user_symptoms.deactivate s
  end
end
["joint pain", "fatigue", "brain fog", "anxiety"].each do |name|
  s = Symptom.create_with(locale: "en").find_or_create_by(name: name)
  [t5].each do |user|
    user.user_symptoms.activate s
  end
end

### TREATMENTS
[
  {name: "Tickles", quantity: "1.0", unit: "session"},
  {name: "Laughing Gas", quantity: "10.5", unit: "cc"}
].each do |treatment|
  t = Treatment.create_with(locale: "en", quantity: treatment[:quantity], unit: treatment[:unit]).find_or_create_by(name: treatment[:name])
  [t1,t2].each do |user|
    user.user_treatments.activate t
  end
end
[
  {name: "Funny Bone Electroshock", quantity: "15.0", unit: "repetition"},
  {name: "Toe Stubbing", quantity: "1.0", unit: "time"}
].each do |treatment|
  t = Treatment.create_with(locale: "en", quantity: treatment[:quantity], unit: treatment[:unit]).find_or_create_by(name: treatment[:name])
  [t1,t2].each do |user|
    user.user_treatments.activate t
    user.user_treatments.deactivate t
  end
end
[
  {name: "methotrexate", quantity: "60.0", unit: "mg"},
  {name: "B12", quantity: "1.0", unit: "tab"}
].each do |treatment|
  t = Treatment.create_with(locale: "en", quantity: treatment[:quantity], unit: treatment[:unit]).find_or_create_by(name: treatment[:name])
  [t5].each do |user|
    user.user_treatments.activate t
  end
end

### CONDITIONS
[ {name: "The Giggles"} ].each do |condition|
  c = Condition.create_with(locale: "en").find_or_create_by(name: condition[:name])
  [t1,t2].each do |user|
    user.user_conditions.activate c
  end
end

[ {name: "Crohn's Disease"} ].each do |condition|
  c = Condition.create_with(locale: "en").find_or_create_by(name: condition[:name])
  [t5].each do |user|
    user.user_conditions.activate c
  end
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
[t1, t2, t3, t4, t5, graham, colin].each do |user|
  at = Date.today+1.day # 1 year ago + 1 day
  Timecop.freeze(at){user.create_audit}
end

### Back to NOW ###
Timecop.return