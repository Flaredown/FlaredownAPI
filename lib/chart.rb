module Chart  
  def chart_coordinates
    coords = []
    REDIS.hgetall("charts:score:#{self.id}").each_pair{|k,v| coords << {x: k.to_i, y: v.to_i}}
    coords
  end
end