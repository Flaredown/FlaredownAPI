class User < ActiveRecord::Base
  include TokenAuth::User
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable  
  validates_numericality_of :weight, :on => :create, :message => "is not a number"
  validates_inclusion_of :weight, :in => [*0..800], :message => "not within allowed values"
  validates_inclusion_of :gender, :in => %w( male female ), :message => "not within allowed values"
  
  def entries
    Entry.by_user_id.key(self.id.to_s)
  end
  
  # TODO move this to it's own controller/model/serializer on a per catalog basis
  
  # TODO enable Redis/Resque on Heroku to use this code
  # def score_coordinates
  #   coords = []
  #   REDIS.hgetall("charts:cdai_score:#{self.id}").each_pair{|k,v| coords << {x: k.to_i, y: v.to_i}}
  #   coords
  # end
  def cdai_score_coordinates
    coords = self.entries.map do |entry|
      score = entry.scores.select{|s| s[:id] == "cdai"}.first.value
      {x: entry.date.to_time.to_i, y: score}
    end
    coords ||= []
    coords
  end
  
end
