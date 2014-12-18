# Clear it out first
REDIS.flushdb
Entry.all.each{|e| e.destroy}
User.all.each{|u| u.destroy}
# old_user=User.find_by_email("test@test.com")
# old_user.delete if old_user

u=User.create(email: "test@test.com", password: "testing123", password_confirmation: "testing123", gender: "male", weight: 145, catalogs: ["hbi"])

500.times do |n|
  FactoryGirl.create :hbi_entry, user: u, date: Date.today-n.days
end