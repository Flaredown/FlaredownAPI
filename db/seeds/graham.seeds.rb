# u = User.find_by(email: "graham@flaredown.com")
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-03-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 3.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.treatments << {name: "ocean sinus rinse", quantity: 1.0, unit: "session"}
# entry.treatments << {name: "nasal spray", quantity: 1.0, unit: "session"}
# entry.notes = "Ocean rinse was tough being stuffed up, felt a bit better about an hour later."
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-04-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 2.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.treatments << {name: "ocean sinus rinse", quantity: 1.0, unit: "session"}
# entry.notes = "Did chest/neck #stretches first thing, good but not great. Much more vigorous/disgusting ocean rinse but found immediate relief."
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-05-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 1.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.notes = "Did chest/neck #stretches first thing."
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-06-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 1.0})
# entry.treatments << {name: "loratadine", quantity: 20.0, unit: "mg"}
# entry.notes = "Did chest/neck #stretches first thing. Took more loratadine, not seeming to help much. Descended into sniffles hell during the evening."
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-07-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 4.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 4.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 1.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.notes = "Full blown attack, could actually be sinus infection. Have a phlegmy cought too."
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-08-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.notes = "#sick today, pretty sure it's an infection moved to the lungs, got a fever but allergies are not so bad."
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-09-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.notes = "#sick some more. Still alergies not bad, mostly just feel like crap."
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-10-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.treatments << {name: "prednisone", quantity: 40.0, unit: "mg"}
# entry.notes = "Recovering from sickness, took some meds, #lungs feel much better and it seems to improve my congestion. #thanksPrednisone"
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-11-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.treatments << {name: "prednisone", quantity: 80.0, unit: "mg"}
# entry.notes = "Still recovering from sickness, allergies minimal #thanksPrednisone"
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-12-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.treatments << {name: "prednisone", quantity: 60.0, unit: "mg"}
# entry.notes = "Allergies minimal #thanksPrednisone"
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-13-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "prednisone", quantity: 20.0, unit: "mg"}
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.notes = "Allergies minimal, still coughing from earlier sickness"
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-14-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.notes = "Allergies minimal, still coughing from earlier sickness"
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-15-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.notes = "Allergies minimal...gone?"
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-16-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.notes = "No allergies"
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-17-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.notes = "Allergies minimal, had a little sneezing fit probably cuz I forgot to take meds until later in the day"
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-18-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.notes = "No Allergies"
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-19-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.notes = "No Allergies"
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-20-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.notes = "Had some sniffles for a bit, shorted lived though"
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-21-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.notes = "A spot of congestion, but not serious"
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-22-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.notes = "More congestion, got a bit worse"
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-23-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.treatments << {name: "prednisone", quantity: 20.0, unit: "mg"}
# entry.treatments << {name: "exercise", quantity: 1.0, unit: "session"}
# entry.notes = "Congestion cleared up"
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-24-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.notes = "All good"
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-25-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.treatments << {name: "exercise", quantity: 1.0, unit: "session"}
# entry.notes = "All good"
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-26-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 1.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.treatments << {name: "exercise", quantity: 1.0, unit: "session"}
# entry.notes = "Evening sniffles, did some exercise and it mostly cleared up"
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-27-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.notes = "More low grade sniffles"
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-28-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.treatments << {name: "prednisone", quantity: 40.0, unit: "mg"}
# entry.notes = "Woke up with some congestion + sniffles... took prednisone"
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-29-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.notes = "Congestion all day"
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-30-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.notes = "Nose running all day"
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-31-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.notes = "Nose running all day"
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Feb-1-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Feb-2-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Feb-3-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.treatments << {name: "prednisone", quantity: 80.0, unit: "mg"}
# entry.notes = "Last ditch super prednisone dose like when I was infected, working pretty good so far..."
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Feb-4-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.notes = "Doing pretty good"
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Feb-5-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.notes = "Doing pretty good"
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Feb-6-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.notes = "Doing pretty good"
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Feb-7-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.notes = "Doing pretty good"
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Feb-8-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.treatments << {name: "sinus rinse", quantity: 1.0, unit: "bottle"}
# entry.notes = "Immediate morning sniffles"
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Feb-9-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.treatments << {name: "sinus rinse", quantity: 1.0, unit: "bottle"}
# entry.notes = "Started the day with some runny nose, proceeded to sinus rinse."
# entry.save
#
# # Skipped some days...
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Feb-18-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.treatments << {name: "sinus rinse", quantity: 1.0, unit: "bottle"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Feb-19-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.treatments << {name: "sinus rinse", quantity: 1.0, unit: "bottle"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Feb-20-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.treatments << {name: "sinus rinse", quantity: 1.0, unit: "bottle"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Feb-21-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.treatments << {name: "sinus rinse", quantity: 1.0, unit: "bottle"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Feb-22-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Feb-23-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "sneezing"  , value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "runny nose", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "congestion", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "itchy throat", value: 0.0})
# entry.treatments << {name: "loratadine", quantity: 10.0, unit: "mg"}
# entry.treatments << {name: "sinus rinse", quantity: 1.0, unit: "bottle"}
# entry.notes = ""
# entry.save
#
#
# Entry.all.each{|e| Entry.perform(e.id,false) if e.user_id == "12"} # process all graham@flaredown.com entries
#
# # Clear Resque because Entries are already processed
# Resque.queues.each{|q| Resque.redis.del "queue:#{q}" }