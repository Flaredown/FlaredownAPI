u = User.find_by(email: "graham@flaredown.com")

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-03-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 3.0})
entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
entry.treatments << {name: "ocean sinus rinse", quantity: 1.0, unit: "session"}
entry.treatments << {name: "nasal spray", quantity: 1.0, unit: "session"}
entry.notes = "Ocean rinse was tough being stuffed up, felt a bit better about an hour later."
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-04-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 1.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 2.0})
entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
entry.treatments << {name: "ocean sinus rinse", quantity: 1.0, unit: "session"}
entry.notes = "Did chest/neck #stretches first thing, good but not great. Much more vigorous/disgusting ocean rinse but found immediate relief."
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-05-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 1.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 1.0})
entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
entry.notes = "Did chest/neck #stretches first thing."
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-06-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 1.0})
entry.treatments << {name: "loratadine", quantity: 20.0, unit: "mg"}
entry.notes = "Did chest/neck #stretches first thing. Took more loratadine, not seeming to help much. Descended into sniffles hell during the evening."
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-07-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 4.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 4.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 1.0})
entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
entry.notes = "Full blown attack, could actually be sinus infection. Have a phlegmy cought too."
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-08-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
entry.notes = "#sick today, pretty sure it's an infection moved to the lungs, got a fever but allergies are not so bad."
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-09-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 1.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
entry.notes = "#sick some more. Still alergies not bad, mostly just feel like crap."
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-10-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 1.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 1.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 1.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
entry.treatments << {name: "prednisone", quantity: 40.0, unit: "mg"}
entry.notes = "Recovering from sickness, took some meds, #lungs feel much better and it seems to improve my congestion. #thanksPrednisone"
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-11-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 1.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
entry.treatments << {name: "prednisone", quantity: 80.0, unit: "mg"}
entry.notes = "Still recovering from sickness, allergies minimal #thanksPrednisone"
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-12-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 1.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
entry.treatments << {name: "prednisone", quantity: 60.0, unit: "mg"}
entry.notes = "Allergies minimal #thanksPrednisone"
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-13-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 1.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
entry.treatments << {name: "prednisone", quantity: 20.0, unit: "mg"}
entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
entry.notes = "Allergies minimal, still coughing from earlier sickness"
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-14-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 1.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
entry.notes = "Allergies minimal, still coughing from earlier sickness"
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-15-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 0.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
entry.notes = "Allergies minimal...gone?"
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-16-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 0.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
entry.notes = "No allergies"
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-17-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 1.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 0.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
entry.notes = "Allergies minimal, had a little sneezing fit probably cuz I forgot to take meds until later in the day"
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-18-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 0.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
entry.notes = "No Allergies"
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-19-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 0.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
entry.notes = "No Allergies"
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-20-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 0.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
entry.notes = "Had some sniffles for a bit, shorted lived though"
entry.save

Entry.all.each{|e| Entry.perform(e.id,false) if e.user_id == "12"} # process all graham@flaredown.com entries

# Clear Resque because Entries are already processed
Resque.queues.each{|q| Resque.redis.del "queue:#{q}" }