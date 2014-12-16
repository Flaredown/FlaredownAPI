class CatalogGraph
  attr_accessor :user_id, :catalogs, :start_date, :end_date
  def initialize(user_id, catalogs, start_date=nil, end_date=nil)
    @user_id    = user_id
    @catalogs   = catalogs

    @start_date = start_date  || 2.week.ago.to_date
    @end_date   = end_date    || Date.today
  end

  def date_range(start_date, end_date)
    (start_date..end_date).to_a.map{|day| day.to_time.utc.beginning_of_day.to_i}
  end

  def medication_data
    medication_coordinates(catalog)
  end
  def catalogs_data
    data = {}
    catalogs.each do |catalog|
      data[catalog] = score_coordinates(catalog)
        # name:         catalog,
        # scores:score_coordinates(catalog)
        # components:   score_component_coordinates(catalog)
    end
    data
  end

  def score_coordinates(catalog, start_date=start_date, end_date=end_date)
    date_range(start_date, end_date).map do |entry_date|

      "#{catalog.capitalize}Catalog".constantize.const_get("SCORE_COMPONENTS").each_with_index.map do |component, i|
        value = REDIS.hget("#{user_id}:scores:#{entry_date}:#{catalog}", component.to_s)
        value.nil? ? nil : {x: entry_date, order: i+1, points: value.to_i, name: component.to_s}
      end

    end.flatten.compact
  end
  def score_component_coordinates(catalog, start_date=start_date, end_date=end_date)
    []
    # date_range(start_date, end_date).map do |entry_date|
    #
    #   value = REDIS.get("#{user_id}:scores:#{entry_date}:#{catalog}_score").to_i
    #   value.zero? ? nil : {x: entry_date, y: value}
    #
    # end.compact.sort_by{|c| c[:x]}
  end
  def medication_coordinates(catalog)
    []
  end

end