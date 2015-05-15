class EntrySendToKeen
  @queue = :entries

  def self.perform(args)
    args = Hashie::Mash.new(args)

    entry_id = args.id
    timestamp = Time.parse(args.timestamp)

    entry = Entry.find(entry_id)

    #jobs = Resque.queues["entries"].find_all { |job| entry_id.match(job["args"][0]) }

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
