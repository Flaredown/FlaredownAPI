module UserTrackables
  extend ActiveSupport::Concern

  included do |base|

    %w( treatments conditions symptoms ).each do |trackable|

      base.class_eval do
        has_many "user_#{trackable}".to_sym
        has_many trackable.to_sym, :through => "user_#{trackable}".to_sym do

          # disable duplicate addition
          def <<(new_item)
            super( Array(new_item) - proxy_association.owner.send(proxy_association.reflection.plural_name.to_sym) )
          end

        end
      end

      define_method("activate_#{trackable.singularize}") do |trackable_object|
        ActiveRecord::Base.transaction do
          self.send(trackable) << trackable_object
          self.update_attribute("active_#{trackable}".to_sym, (self.send("active_#{trackable}") | [trackable_object.id.to_s]))
        end
      end

      define_method("deactivate_#{trackable.singularize}") do |trackable_object|
        self.update_attribute("active_#{trackable}".to_sym, (self.send("active_#{trackable}") - [trackable_object.id.to_s]))
      end

      define_method("current_#{trackable}") do
        trackable.singularize.capitalize.constantize.where(id: self.send("active_#{trackable}".to_sym).map(&:to_i))
      end

    end
  end

end