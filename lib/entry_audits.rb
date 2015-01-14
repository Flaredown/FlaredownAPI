module EntryAudits

  # Get's the latest version of the User.paper_trail based on day
  #
  # day - Ruby Date (utc)
  #
  # Examples
  #
  #   audit_for_day(Date.today)
  #
  #   => PaperTrail::Version
  #
  # Returns a User instance
  def applicable_audit
    live_user = User.find(self.user_id)
    version = live_user.versions.where("created_at < ?", date.end_of_day).reorder(created_at: :desc, id: :desc).limit(1).first
    return false if version and version.reify.next_version.live?
    version
  end

  def set_user_audit_version!
    self.user_audit_version = applicable_audit.index if applicable_audit

    # user.conditions.each do |condition|
    #   self.conditions << condition.name
    # end

    user.catalogs.each do |catalog|
      self.catalogs << catalog
    end

    user.treatments.each do |treatment|
      self.treatments << treatment.attributes.extract!(*%w( name quantity unit ))
    end

    save_without_processing
    self
  end
end