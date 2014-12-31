namespace :entries do

  desc "Process entries for data science seed users"
  task process_data_science: :environment do
    Entry.all.each do |e|
      Entry.perform(e.id) if ["11","100"].include? e.user_id
    end
  end

end