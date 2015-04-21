u = User.find_by(email: "test@flaredown.com")

# Add entries for test user
20.times do |n|
  e=FactoryGirl.create :hbi_and_symptoms_entry, user: u, date: Date.today-n.days-5
  e.setup_with_audit!
end

Entry.all.each{|e| Entry.perform(e.id,false) if e.user_id == "1"} # process all test@flaredown.com entries

# Clear Resque because Entries are already processed
Resque.queues.each{|q| Resque.redis.del "queue:#{q}" }