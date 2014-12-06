require 'sidekiq'

class ImportantWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :critical

  def perform(*important_args)
    puts "Doing critical work"
  end
end