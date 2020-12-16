class HardWorker
  include Sidekiq::Worker
  sidekiq_options :backtrace => 5

  def perform
    puts "hello"
  end
end
