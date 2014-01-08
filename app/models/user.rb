class User < ActiveRecord::Base
  include Chart
  include TokenAuth::User
  
  has_many :entries
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable  
  validates_numericality_of :weight, :on => :create, :message => "is not a number"
  validates_inclusion_of :weight, :in => [*0..800], :message => "not within allowed values"
  validates_inclusion_of :gender, :in => %w( male female ), :message => "not within allowed values"
end
