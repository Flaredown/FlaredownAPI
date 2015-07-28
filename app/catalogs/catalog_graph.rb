class CatalogGraph
  attr_accessor :user_id, :catalogs, :start_date, :end_date
  def initialize(user_id, start_date=nil, end_date=nil)
    @user_id    = user_id
    @catalogs   = User.find(@user_id).catalogs | Globals::PSEUDO_CATALOGS

    @start_date = start_date  || 2.week.ago.to_date
    @end_date   = end_date    || Date.today

    user = User.find(@user_id)

    @all_symptoms_names = user.symptoms.map(&:name)
    @all_conditions_names = user.conditions.map(&:name)
    @all_treatments_names = user.treatments.map(&:name)
  end

  def date_range(start_date, end_date)
    (start_date..end_date).to_a.map{|day| day.to_time.utc.beginning_of_day.to_i}
  end

  def catalogs_data
    catalogs.reduce({}) do |accum,catalog|
      accum[catalog] = score_coordinates(catalog)
      accum
    end
  end

  def score_coordinates(catalog, start_date=nil, end_date=nil)
    start_date  ||= @start_date
    end_date    ||= @end_date
    date_range(start_date, end_date).map do |entry_date|

      components = if Globals::PSEUDO_CATALOGS.include?(catalog)
        self.instance_variable_get("@all_#{catalog}_names")
      else
        "#{catalog.capitalize}Catalog".constantize.const_get("SCORE_COMPONENTS")
      end

      components.each_with_index.map do |component, i|
        value = REDIS.hget("#{user_id}:scores:#{entry_date}:#{catalog}", component.to_s)
        value.nil? ? nil : {x: entry_date, order: i+1, points: value.to_i, name: component.to_s}
      end

    end.flatten.compact
  end

end