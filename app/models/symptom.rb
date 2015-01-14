class Symptom < ActiveRecord::Base

  has_paper_trail

  has_many :user_symptoms
  has_many :users, :through => :user_symptoms

  # TODO I18n for messages ...
  # en:
  #   activerecord:
  #     errors:
  #       models:
  #         symptom:
  validates_presence_of :name
  validates_uniqueness_of :name, message: "Name already exists"
  validates_length_of :name, maximum: 50, message: "Name cannot be longer then 50 charachters"
  validates_format_of :name, with: /^[a-zA-Z0-9 -]*$/ , multiline: true, message: "Name can only include alphanumeric characters, hyphens and spaces"
  validate :is_profane

  def is_profane
    if Obscenity.profane?(name)
      errors.add(:name, "Please do not use obscene words")
    end
  end

end
