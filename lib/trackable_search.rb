module TrackableSearch
  def search_trackable(name)
    ActiveRecord::Base.connection.execute("SELECT set_limit(0.05);")

    klass       = controller_name.classify.constantize
    trackables  = klass.fuzzy_search(name: name).limit(10)

    # TODO will this be performant down the road?
    trackables.map do |trackable|
      {
        name: trackable[:name],
        count: "User#{klass}".constantize.where("#{klass.to_s.downcase}_id = ?", trackable[:id]).count
      }
    end

    # symptom_ids = []
    # for symptom in symptoms
    #   symptom_ids.push symptom.id
    # end
    # ids = symptom_ids.map(&:inspect).join(', ')
    # catalogs = current_user.active_catalogs
    # catalogs_string = ""
    # catalogs.each_with_index do |catalog, index|
    #   if index == (catalogs.length-1) then
    #     catalogs_string =  catalogs_string + "'#{catalog}'"
    #   else
    #     catalogs_string = catalogs_string + "#{catalog}',"
    #   end
    # end
    # overlapping_results = Symptom.where("id IN (#{ids}) and related_catalogs && ARRAY[#{catalogs_string}]")
    # overlapping_results_ids = [];
    # for overlapping_result in overlapping_results
    #   overlapping_results_ids.push overlapping_result.id
    # end
    # results = []
    # results = results + overlapping_results
    # result_count = overlapping_results.length;
    # for symptom in symptoms
    #   if !overlapping_results_ids.include?(symptom.id)
    #     if result_count < 10
    #       results.push symptom
    #       result_count = result_count + 1
    #     else
    #       break
    #     end
    #   end
    # end

  end
end