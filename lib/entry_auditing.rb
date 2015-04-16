module EntryAuditing

  TRACKABLES = %w( conditions treatments symptoms )

  # Get's the latest version of the User.paper_trail based on Entry day
  def applicable_audit
    user.versions.where("created_at <= ?", date.end_of_day).reorder(created_at: :desc).limit(1).first
  end

  # Determines if the audit being used is last available one
  def using_latest_audit?
    return true if applicable_audit.nil?

    sorted_versions = user.reload.versions.sort_by(&:created_at)
    sorted_versions.index(applicable_audit) == sorted_versions.count-1
  end

  # Reified user for the applicable audit
  def audit_user
    applicable_audit ? applicable_audit.reify(has_many: true) : user
  end

  # Add relevant associations to Entry based on applicable_audit
  def setup_with_audit!
    self.settings   = audit_user.settings
    self.treatments = reified_actives_for("treatments").map do |t|
      uniq_name      = "treatment_#{t["name"]}"
      quantity, unit = settings["#{uniq_name}_quantity"], settings["#{uniq_name}_unit"]

      {name: t["name"], quantity: quantity, unit: unit}
    end
    self.conditions = reified_actives_for("conditions").map(&:name)
    self.catalogs   = self.conditions.map { |c| CATALOG_CONDITIONS[c] }.compact

    save_without_processing
    self
  end

  # Update the user based on Entry contents and create a version if necessary
  def update_audit
    self.reload

    if date.today? and (trackables_present? or not self.settings.eql?(user.settings))
      user.update_settings(self.settings)

      sync_trackables

      self.reload
      user.create_audit
    end

  end

  # Defines the symptoms catalog based on active_symptoms from the audit
  def symptoms_definition
    names = symptoms.present? ? symptoms : reified_actives_for("symptoms").map(&:name)
    names.map do |symptom|
      basic_question(symptom)
    end
  end

  private

  def trackables_present?
    trackables_to_sync.each do |group|
      return true if group.values.flatten.present?
    end
    false
  end
  def trackables_to_sync
    adds,removes = {},{}

    TRACKABLES.each do |kind|
      existing = user.send("active_#{kind}").map(&:name)

      if kind == "treatments"
        incoming = self.send(kind).map(&:name)
      else
        incoming = self.send(kind)
      end

      adds[kind]      = incoming - existing
      removes[kind]   = existing - incoming

    end

    [adds,removes]
  end

  # Adds/removes trackables based on difference between audit and live user version
  def sync_trackables
    action = :activate
    trackables_to_sync.each do |group|
      group.each do |kind,names|
        toggle_trackable(kind, names, action) if names.present?
      end
      action = :deactivate
    end
  end

  # Toggles the state active of a trackable
  def toggle_trackable(kind,names,action)
    klass = kind.singularize.capitalize.constantize
    assoc = user.send("user_#{kind}")

    names.each do |name|
      trackable = klass.find_or_create_by(name: name)
      assoc.send(action,trackable)
    end
  end

  # Actives at the time of the audit for kind
  def reified_actives_for(kind)
    actives     = audit_user.send("user_#{kind}").select(&:active)
    active_ids  = actives.map(&"#{kind.singularize}_id".to_sym)
    assoc       = audit_user.send(kind)

    assoc.where(id: active_ids)
  end


end