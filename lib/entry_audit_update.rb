class EntryAuditUpdate
  @queue = :entries

  def self.perform(entry_id)
    entry = Entry.find(entry_id)
    entry.update_audit
  end
end