class CatalogGraph
  attr_accessor :user_id, :catalogs, :start_date, :end_date
  def initialize(user_id, catalogs, start_date=nil, end_date=nil)
    @user_id    = user_id
    @catalogs   = catalogs

    @start_date = start_date  || 2.week.ago.to_date
    @end_date   = end_date    || Date.today

    @all_symptom_names = User.find(@user_id).symptoms.map(&:name)
  end

  def date_range(start_date, end_date)
    (start_date..end_date).to_a.map{|day| day.to_time.utc.beginning_of_day.to_i}
  end

  def medication_data
    medication_coordinates#(catalog)
  end
  def catalogs_data
    data = {}
    catalogs.each do |catalog|
      data[catalog] = score_coordinates(catalog)
        # name:         catalog,
        # scores:score_coordinates(catalog)
        # components:   score_component_coordinates(catalog)
    end
    data["treatments"] = treatment_coordinates
    data
  end

  def score_coordinates(catalog, start_date=start_date, end_date=end_date)
    date_range(start_date, end_date).map do |entry_date|

      components = ((catalog == "symptoms") ? @all_symptom_names : "#{catalog.capitalize}Catalog".constantize.const_get("SCORE_COMPONENTS"))

      components.each_with_index.map do |component, i|
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
  # def medication_coordinates(catalog)
  #   []
  # end

  def treatment_coordinates
    return []
    i,j = 0,0
    (score_coordinates("symptoms").map do |score|
      {order: 1, x: score[:x], name: "Tickles", quantity: "20 minutes"}
    end[0..-4] |
    score_coordinates("symptoms").map do |score|
      i = i+1
      {order: 2, x: score[:x], name: "Laughing Gas", quantity: "4 hours"} if i > 4
    end |
    score_coordinates("symptoms").map do |score|
      j = j+1
      {order: 3,x: score[:x], name: "Toe Stubbing", quantity: "0.00005 mg"} if j < 7
    end).compact!
  end

end