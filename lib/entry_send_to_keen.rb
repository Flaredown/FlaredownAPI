class EntrySendToKeen
  @queue = :entries

  def self.perform(entry_id)
    entry = Entry.find(entry_id)

    #jobs = Resque.queues["entries"].find_all { |job| entry_id.match(job["args"][0]) }

    timestamp = Time.now  # TODO: need to pass this in to get time entered, not time sent

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
