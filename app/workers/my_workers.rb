class MyWorker
  include Sidekiq::Worker

  def perform(arg1, arg2)
    # Your background job logic here
  end
end
