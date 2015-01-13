class Treatment < ActiveRecord::Base
  has_many :user_treatments
  has_many :users, :through => :user_treatments

  # TODO I18n for messages ...
  # en:
  #   activerecord:
  #     errors:
  #       models:
  #         treatment:
  validates_presence_of :name
  validates_uniqueness_of :name, message: "Name already exists"
  validates_length_of :name, maximum: 50, message: "Name cannot be longer then 50 charachters"
  validates_format_of :name, with: /^[a-zA-Z0-9 -]*$/ , multiline: true, message: "Name can only include alphanumeric characters, hyphens and spaces"

  validates_presence_of :quantity

  validates_presence_of :unit
  validates_length_of :unit, maximum: 20, message: "Unit cannot be longer then 20 charachters"
  validates_format_of :unit, with: /^[a-zA-Z0-9 -]*$/ , multiline: true, message: "Unit can only include alphanumeric characters, hyphens and spaces"

  validate :is_profane

  def is_profane
    if Obscenity.profane?(name)
      errors.add(:name, "Please do not use obscene words")
    end
  end

end