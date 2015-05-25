require 'resque/tasks'
require 'resque_scheduler/tasks'

task "resque:setup" => :environment do
  ENV['QUEUE'] ||= '*'

  #for redistogo on heroku http://stackoverflow.com/questions/2611747/rails-resque-workers-fail-with-pgerror-server-closed-the-connection-unexpectedl
  Resque.before_fork = Proc.new { ActiveRecord::Base.establish_connection }
end

task "resque:scheduler_setup" => :environment

desc "schedule and work, so we only need 1 dyno"
task "resque:schedule_and_work" => :environment do
  if Process.fork
    sh "rake environment resque:work"
  else
    sh "rake environment resque:scheduler"
    Process.wait
  end
end