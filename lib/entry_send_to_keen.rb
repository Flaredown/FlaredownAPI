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
      :date => entry.date,
      :user_id => entry.user.id.to_s,
      :local_time_hour => timestamp.hour,
      :time_zone => timestamp.zone,
      :day_of_week => timestamp.wday,
      :n_catalogs => entry.catalogs.length
    }

    Keen.publish(:entries, entry_to_keen)
  end
end
