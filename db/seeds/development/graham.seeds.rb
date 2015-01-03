Entry.all.each{|e| e.destroy if e.user_id == "12"} # wipe out graham@flaredown.com entries

u=User.create(id: 12, email: "graham@flaredown.com", password: "testing123", password_confirmation: "testing123", gender: "male", weight: 145, catalogs: [])

# Add symptom names from :hbi_and_symptoms_entry
active_symptoms = []
["sneezing", "runny nose", "congestion"].each do |name|
  s = Symptom.create_with(language: "en").find_or_create_by(name: name)
  u.symptoms << s
  active_symptoms << s.id
end
u.update_attribute(:active_symptoms, active_symptoms)

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-03-2015")

entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 2.0})
entry.treatments << FactoryGirl.build(:treatment, {name: "loratadine", quantity: 10.0, unit: "mg"})
entry.treatments << FactoryGirl.build(:treatment, {name: "ocean sinus rinse", quantity: 1.0, unit: "session"})
entry.notes = "Ocean rinse was tough being stuffed up, felt a bit better about an hour later."
entry.save


Entry.all.each{|e| Entry.perform(e.id) if e.user_id == "12"} # process all graham@flaredown.com entries