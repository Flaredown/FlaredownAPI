class EntrySendToKeen
  @queue = :keen

  def self.perform(args)
    args = Hashie::Mash.new(args)

    entry_id = args.id
    timestamp = Time.parse(args.timestamp)

    entry = Entry.find(entry_id)
    # Resque.enqueue_at(1.day.from_now, EntrySendToKeen, {id: "a18679eb3e82505143ea904f0bc0de6a", timestamp: Date.today.to_time.to_s})

    # match all args
    # Resque.remove_delayed(EntrySendToKeen, {id: "a18679eb3e82505143ea904f0bc0de6a", timestamp: Date.today.to_time.to_s})

    # Or just match the entry id
    Resque.remove_delayed_selection { |args| args[0]['id'] == entry.id }

    entry_to_keen = {
    	:id => entry.id,
		:date => entry.date,
      	:user_id => entry.user.id.to_s,
      	:local_time_hour => timestamp.hour,
      	:time_zone => timestamp.zone,
      	:day_of_week => timestamp.wday,
      	:n_catalogs => entry.catalogs.length
    }

    entry.catalogs.each do |catalog|
    	catalog_score = entry.scores.detect {|s| s["name"] == catalog}

    	catalog_to_keen = {
    		:name => catalog,
    		:entry_id => entry.id,
    		:date => entry.date,
    		:user_id => entry.user.id.to_s,
    		:score => catalog_score["score"],
    	}
    	Keen.publish(:catalogs, catalog_to_keen)
    end

    entry.symptoms.each do |symptom|
    	symptom_response = entry.responses.detect {|r| r["name"] == symptom}

    	symptom_to_keen = {
    		:name => symptom,
    		:entry_id => entry.id,
    		:date => entry.date,
    		:user_id => entry.user.id.to_s,
    		:score => symptom_response["value"],
    	}
    	Keen.publish(:symptoms, symptom_to_keen)
    end

    entry.treatments.each do |treatment|
    	treatment_to_keen = {
    		:name => treatment.name,
    		:entry_id => entry.id,
    		:date => entry.date,
    		:user_id => entry.user.id.to_s,
    		:quantity => treatment.quantity,
    		:unit => treatment.unit,
    		:repetition => treatment.repetition,
    	}
    	Keen.publish(:treatments, treatment_to_keen)
    end

    Keen.publish(:entries, entry_to_keen)
  end
end
