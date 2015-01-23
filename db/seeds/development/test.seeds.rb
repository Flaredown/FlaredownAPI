u = User.find_by(email: "test@test.com")

# Add entries for test user
100.times do |n|
  e=FactoryGirl.create :hbi_and_symptoms_entry, user: u, date: Date.today-n.days-5
  e.setup_with_audit!
end

Entry.all.each{|e| Entry.perform(e.id,false) if e.user_id == "1"} # process all test@test.com entries

# Clear Resque because Entries are already processed
Resque.queues.each{|q| Resque.redis.del "queue:#{q}" }