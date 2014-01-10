module Chart  
  # TODO enable Redis/Resque on Heroku to use this code
  # def score_coordinates
  #   coords = []
  #   REDIS.hgetall("charts:score:#{self.id}").each_pair{|k,v| coords << {x: k.to_i, y: v.to_i}}
  #   coords
  # end
  def score_coordinates
    coords = self.entries.map{|entry| {x: entry.date, y: entry.score}}
    coords ||= []
    coords
  end
end