# u = User.find_by(email: "video@flaredown.com")
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-07-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
# entry.treatments << {name: "methotrexate", quantity: 60.0, unit: "mg"}
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-08-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 2.0})
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-09-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 4.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 2.0})
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-10-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 4.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-11-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 4.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-12-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-13-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 4.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-14-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
# entry.treatments << {name: "methotrexate", quantity: 60.0, unit: "mg"}
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-15-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-16-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 4.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 4.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-17-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-18-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 4.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-19-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-20-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 4.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-21-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 2.0})
# entry.treatments << {name: "methotrexate", quantity: 60.0, unit: "mg"}
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-22-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-23-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-24-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 4.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-25-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 4.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-26-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-27-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 4.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 0.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 2.0})
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-28-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
# entry.treatments << {name: "methotrexate", quantity: 60.0, unit: "mg"}
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-29-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-30-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Jan-31-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Feb-01-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 4.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Feb-02-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 4.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Feb-03-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 4.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 3.0})
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Feb-04-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 1.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
# entry.treatments << {name: "methotrexate", quantity: 60.0, unit: "mg"}
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Feb-05-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 2.0})
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Feb-06-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 4.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# entry = FactoryGirl.build :entry, user: u, date: Date.parse("Feb-07-2015")
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "joint pain"  , value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "fatigue", value: 2.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "brain fog", value: 3.0})
# entry.responses << FactoryGirl.build(:response, {catalog: "symptoms", name: "anxiety", value: 1.0})
# entry.treatments << {name: "B12", quantity: 1.0, unit: "tab"}
# entry.notes = ""
# entry.save
#
# Entry.all.each{|e| Entry.perform(e.id,false) if e.user_id == "5"} # process all video@flaredown.com entries
#
# # Clear Resque because Entries are already processed
# Resque.queues.each{|q| Resque.redis.del "queue:#{q}" }