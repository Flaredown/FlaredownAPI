class CatalogChart
  attr_accessor :user_id, :catalog
  def initialize(user_id, catalog)
    @user_id = user_id
    @catalog = catalog
  end
  
  def date_range(start_date, end_date)
    (start_date..end_date).to_a.map{|day| day.to_time.to_i}
  end
  
  def score_coordinates(start_date=1.week.ago.to_date, end_date=Date.today)
    date_range(start_date, end_date).map do |entry_date|
      
      value = REDIS.get("#{user_id}:scores:#{entry_date}:#{catalog}_score").to_i
      value.zero? ? nil : {x: entry_date, y: value}
      
    end.compact.sort_by{|c| c[:x]}
  end
  
end