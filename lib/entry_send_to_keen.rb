class EntrySendToKeen
  @queue = :entries

  def self.perform(entry_id)
    entry = Entry.find(entry_id)

    entry_to_keen = {
      :date => entry.date,
      :user_id => entry.user.id.to_s,
      :local_time_hour => Time.now.hour,
      :time_zone => Time.now.zone,
      :day_of_week => Time.now.wday,
      :n_catalogs => entry.catalogs.length
    }

    Keen.publish(:entries, entry_to_keen)
  end
end
