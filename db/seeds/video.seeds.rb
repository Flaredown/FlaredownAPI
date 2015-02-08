u = User.find_by(email: "video@flaredown.com")

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-03-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 1.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
entry.treatments << {name: "methotrexate", quantity: 60.0, unit: "mg"}
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-03-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 2.0})
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-03-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 4.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 2.0})
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-03-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 4.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-03-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 4.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-03-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-03-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 4.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-03-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
entry.treatments << {name: "methotrexate", quantity: 60.0, unit: "mg"}
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-03-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-03-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 4.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 4.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-03-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-03-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 4.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-03-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-03-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 4.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-03-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 1.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 1.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 2.0})
entry.treatments << {name: "methotrexate", quantity: 60.0, unit: "mg"}
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-03-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 1.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 1.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-03-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 1.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-03-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 4.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 1.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-03-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 4.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 1.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-03-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 0.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-03-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 4.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 0.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 2.0})
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-03-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
entry.treatments << {name: "methotrexate", quantity: 60.0, unit: "mg"}
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-03-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-03-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-03-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Feb-01-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 4.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Feb-02-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 4.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Feb-03-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 4.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 3.0})
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Feb-04-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 1.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
entry.treatments << {name: "methotrexate", quantity: 60.0, unit: "mg"}
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Feb-05-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 2.0})
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Feb-06-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 4.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

entry = FactoryGirl.build :entry, user: u, date: Date.parse("Feb-07-2015")
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 2.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
entry.notes = ""
entry.save

Entry.all.each{|e| Entry.perform(e.id,false) if e.user_id == "5"} # process all video@flaredown.com entries

# Clear Resque because Entries are already processed
Resque.queues.each{|q| Resque.redis.del "queue:#{q}" }