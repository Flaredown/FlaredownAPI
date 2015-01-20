module EntryAudits

  # Get's the latest version of the User.paper_trail based on Entry day
  #
  # Examples
  #
  #   applicable_audit
  #
  #   => PaperTrail::Version
  #
  # Returns a User instance
  def applicable_audit
    user.versions.where("created_at <= ?", date.end_of_day).reorder(created_at: :desc).limit(1).first
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
    self.catalogs   = reified_actives_for("conditions").map { |c| CATALOG_CONDITIONS[c.name] }.compact

    save_without_processing
    self
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

  # Actives at the time of the audit for kind
  def reified_actives_for(kind)
    actives = audit_user.send("user_#{kind}").select(&:active)
    audit_user.send(kind).where(id: actives.map(&"#{kind.singularize}_id".to_sym))
  end


end