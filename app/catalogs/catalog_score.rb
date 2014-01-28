module CatalogScore
  
  def save_score(catalog)
    @catalog = catalog
    score, components = calculate_score
    
    entry_score = scores.select{|s| s[:name] == @catalog}.first
    if entry_score
      entry_score.write_attribute("value", score)
    else
      scores << {name: @catalog, value: score}
    end
    
    components.each do |component|
      REDIS.hset("#{user_id}:scores:#{date.to_time.to_i}:#{@catalog}", component[:name], component[:score])
    end
    REDIS.set("#{user_id}:scores:#{date.to_time.to_i}:#{@catalog}_score", score)
  end
  
  def calculate_score
    try("setup_#{@catalog}_scoring")
    
    components = send("valid_#{@catalog}_entry?") ? calculate_score_components : []
    score = components.reduce(0) do |result, component|
      result + component[:score]
    end
    
    [score, components]
  end
  
  def calculate_score_components
    self.class.const_get("#{@catalog.upcase}_SCORE_COMPONENTS").map do |component|
      {name: component.to_s, score: send("#{@catalog}_#{component}_score")}
    end
  end
  
  def update_upcoming_catalog(catalog)
    REDIS.zadd("#{user_id}:upcoming_catalogs", self.class.const_get("#{catalog.upcase}_EXPECTED_USE").last, catalog)
  end

end