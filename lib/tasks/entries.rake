namespace :entries do

  desc "Process entries for data science seed users"
  task process_data_science: :environment do
    Entry.all.each do |e|
      Entry.perform(e.id) if ["11","100"].include? e.user_id
    end
  end

  desc "Destroy entries for data science seed users"
  task destroy_data_science: :environment do
    Entry.all.each do |e|
      e.destroy if ["11","100"].include? e.user_id
    end
  end

end