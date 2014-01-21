class Question < ActiveRecord::Base
  # serialize :options # TODO upgrade to hstore when it's available :: http://inopinatus.org/2013/07/12/using-arrays-of-hstore-with-rails-4/
  has_many :inputs, class_name: "QuestionInput"
    
  validates_presence_of     :name, :message => "can't be blank"
  validates_uniqueness_of   :name, :message => "must be unique"
  validates_format_of       :name, :with => /\A[a-z_]+\z/, :message => "is invalid"
  validates_presence_of     :kind, :message => "can't be blank"
  validates_presence_of     :section, :message => "can't be blank"
  validates_numericality_of :section, :message => "is not a number"
  
  # validate :input_attributes
  
  def localized_name
    I18n.t("questions.#{self.name}")
  end
  
  private
  def input_attributes
    self.errors.add :inputs, "No options present" if kind == "select" and not inputs.count > 1
    
    inputs.each do |input|
      self.errors.add :inputs, "Missing value on option" if input[:value].nil?
    end
    
  end
  
end