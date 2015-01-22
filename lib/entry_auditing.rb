module EntryAuditing

  # Get's the latest version of the User.paper_trail based on Entry day
  def applicable_audit
    user.versions.where("created_at <= ?", date.end_of_day).reorder(created_at: :desc).limit(1).first
  end

  def using_latest_audit?
    return true if applicable_audit.nil?

    sorted_versions = user.versions.sort_by(&:created_at)
    sorted_versions.index(applicable_audit) == sorted_versions.count-1
  end

  # Reified user for the applicable audit
  def audit_user
    applicable_audit ? applicable_audit.reify(has_many: true) : user
  end

  # Add relevant associations to Entry based on applicable_audit
  def setup_with_audit!
    reified_actives_for("treatments").each do |treatment|
      self.treatments << treatment.attributes.extract!(*%w( name quantity unit ))
    end
    self.conditions = reified_actives_for("conditions").map(&:name)
    self.catalogs   = self.conditions.map { |c| CATALOG_CONDITIONS[c] }.compact

    save_without_processing
    self
  end

  # Update the user based on Entry contents and create a version if necessary
  def update_audit
    if using_latest_audit?
      self.reload
      %w( conditions treatments symptoms ).each do |trackable|
        sync_trackables(trackable)
      end

      user.create_audit
    end
  end

  # Defines the symptoms catalog based on active_symptoms from the audit
  def symptoms_definition
    reified_actives_for("symptoms").map do |symptom|
      [{
        name: symptom.name,
        kind: :select,
        inputs: [
          {value: 0, label: "", meta_label: "", helper: nil},
          {value: 1, label: "", meta_label: "", helper: nil},
          {value: 2, label: "", meta_label: "", helper: nil},
          {value: 3, label: "", meta_label: "", helper: nil},
          {value: 4, label: "", meta_label: "", helper: nil},
        ]
      }]
    end
  end

  private

  def sync_trackables(kind)
    existing  = user.send("active_#{kind}").map(&:name)

    if kind == "treatments"
      incoming = self.send(kind).map(&:name)
    else
      incoming = self.send(kind)
    end

    adds      = incoming - existing
    removes   = existing - incoming

    toggle_trackable(kind, adds, :activate)
    toggle_trackable(kind, removes, :deactivate)
  end

  def toggle_trackable(kind,names,action)
    klass = kind.singularize.capitalize.constantize
    assoc = user.send("user_#{kind}")

    names.each do |name|
      trackable = klass.find_or_create_by(name: name)

      if action == :activate
        assoc.activate(trackable)
      else
        assoc.deactivate(trackable)
      end

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