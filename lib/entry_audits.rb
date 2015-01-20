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
    version = user.versions.where("created_at >= ?", date.end_of_day).reorder(created_at: :asc, id: :desc).limit(1).first
    version ? version : false
  end

  def set_user_audit_version!
    audit = applicable_audit
    self.user_audit_version = audit.index if audit

    user.current_catalogs.each do |catalog|
      self.catalogs << catalog
    end

    user.active_treatments.each do |treatment|
      self.treatments << treatment.attributes.extract!(*%w( name quantity unit ))
    end

    user.active_conditions.each do |condition|
      self.conditions << condition.name
    end

    save_without_processing
    self
  end
end