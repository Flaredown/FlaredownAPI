module CatalogScore
  def save_score(catalog)
    @catalog = catalog
    score, components = calculate_score

    entry_score = scores.select{|s| s[:name] == @catalog}.first
    if entry_score
      entry_score.write_attribute("value", score)
    else
      scores << Score.new({name: @catalog, value: score})
    end

    unix_utc = date.to_time.utc.beginning_of_day.to_i

    # clear it first
    REDIS.del("#{user_id}:scores:#{unix_utc}:#{@catalog}")
    REDIS.del("#{user_id}:scores:#{unix_utc}:#{@catalog}_score")

    components.each do |component|
      REDIS.hset("#{user_id}:scores:#{unix_utc}:#{@catalog}", component[:name], component[:score])
    end
    REDIS.set("#{user_id}:scores:#{unix_utc}:#{@catalog}_score", score)
  end

  def catalog_module
    "#{@catalog.capitalize}Catalog".constantize
  end

  def calculate_score
    # Do any custom setup of scoring
    try("setup_#{@catalog}_scoring")

    if send("complete_#{@catalog}_entry?")
      components = calculate_score_components

      # Combine components
      score = components.reduce(0) do |result, component|
        value = component[:score].nil? ? 0 : component[:score]
        result + value
      end

      # Do any custom finalization of score
      score = send("finalize_#{@catalog}_scoring", score) if self.respond_to?("finalize_#{@catalog}_scoring")

      return [score, components]
    else
      return [-1, []] # -1 == incomplete
    end
  end

  # Calls each component method based off the SCORE_COMPONENTS constant
  # First tries "_score" method for any customized calculations, otherwise falls back to simply grabbing the numeric score
  #
  # Returns an array of component scores like: {name: "some_component", score: 123}
  def calculate_score_components

    # TODO what an ugly logic split ... gotta wait for Trackables refactor ...
    if Globals::PSEUDO_CATALOGS.include?(@catalog)
      if @catalog == "treatments"
        treatments.map do |treatment|
          {name: treatment.name, score: (treatment.taken? ? 1.0 : 0.0) }
        end.compact
      else
        responses.select{|r| r.catalog == @catalog }.map do |response|
          {name: response.name, score: response.value }
        end
      end
    else
      catalog_module.const_get("SCORE_COMPONENTS").map do |component|
        score = respond_to?("#{@catalog}_#{component}_score") ? send("#{@catalog}_#{component}_score") : send("#{@catalog}_#{component}")
        {name: component.to_s, score: score}
      end
    end
  end

  ### Was used for CDAI weekly stuff, TODO decide whether it belongs?
  def update_upcoming_catalog(catalog)
    # @catalog = catalog
    # REDIS.zadd("#{user_id}:upcoming_catalogs", catalog_module.const_get("#{@catalog.upcase}_EXPECTED_USE").last, @catalog)
  end

end