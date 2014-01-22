class Question < ActiveRecord::Base
  # serialize :options # TODO upgrade to hstore when it's available :: http://inopinatus.org/2013/07/12/using-arrays-of-hstore-with-rails-4/
  has_many :inputs, class_name: "QuestionInput"
    
  validates_presence_of     :name, :message => "can't be blank"
  validates_uniqueness_of   :name, :message => "must be unique"
  validates_format_of       :name, :with => /\A[a-z_]+\z/, :message => "is invalid"
  validates_presence_of     :kind, :message => "can't be blank"
  validates_presence_of     :section, :message => "can't be blank"
  validates_numericality_of :section, :message => "is not a number"
  validates_inclusion_of    :section, :in => [*1..100], :message => "section %s needs to be between 1 and 100"
  
  
  def localized_name
    I18n.t("questions.#{self.name}")
  end
  
end