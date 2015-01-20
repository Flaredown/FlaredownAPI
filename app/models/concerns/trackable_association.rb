module TrackableAssociation

  def item_class_name(item)
    item.class.to_s.downcase.to_sym
  end

  def activate(item)
    if existing = find_by(:"#{item_class_name(item)}_id" => item.id)
      existing.update_attribute(:active, true)
    else
      self.create_with(active: true).create(:"#{item_class_name(item)}_id" => item.id)
    end
  end

  def deactivate(item)
    find_by(:"#{item_class_name(item)}_id" => item.id).update_attribute(:active, false)
  end

end