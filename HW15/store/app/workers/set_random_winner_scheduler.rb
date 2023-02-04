require 'sidekiq-scheduler'

class SetRandomWinnerScheduler
  include Sidekiq::Worker

  def perform
    SetRandomWinnerService.new(class_name: 'Io').call
  end
end
