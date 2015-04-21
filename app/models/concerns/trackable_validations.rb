module TrackableValidations
  extend ActiveSupport::Concern

  self.included do
    validates_presence_of :name
    validates_uniqueness_of :name, message: "name_exists"
    validates_length_of :name, maximum: 100, message: "100_char_max_length"
    validates_format_of :name, with: /^[a-zA-Z0-9 '-]*$/ , multiline: true, message: "only_alphanumeric_hyphens_and_spaces"
    validate :is_profane

    def is_profane
      if Obscenity.profane?(name)
        errors.add(:name, "no_obscenities")
      end
    end
  end
end
