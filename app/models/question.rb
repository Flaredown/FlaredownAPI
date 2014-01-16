class Question < ActiveRecord::Base
  serialize :options # TODO upgrade to hstore when it's available :: http://inopinatus.org/2013/07/12/using-arrays-of-hstore-with-rails-4/
    
  validates_presence_of     :name, :message => "can't be blank"
  validates_uniqueness_of   :name, :message => "must be unique"
  validates_format_of       :name, :with => /\A[a-z_]+\z/, :message => "is invalid"
  validates_presence_of     :kind, :message => "can't be blank"
  validates_presence_of     :section, :message => "can't be blank"
  validates_numericality_of :section, :message => "is not a number"
  
  validate :options_attributes
  
  def localized_name
    t(self.name)
  end
  
  private
  def options_attributes
    self.errors.add :options, "No options present" if kind == "select" and not options.count > 1
    
    if options.present?
      options.each do |option|
        self.errors.add :options, "Missing value on option" if option[:value].nil?
      end
    end
    
  end
  
end