class ApplicationController < ActionController::Base
  protect_from_forgery

  latest = Entry.last
  now = Time.new
  if latest.date > now.beginning_of_day.to_datetime.to_i*1000
  	@today = "logged"
  else
  	@today = "unlogged"
  end

end
