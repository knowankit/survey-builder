class WelcomeEmailWorker
  include Sidekiq::Worker

  def perform(user_id)
    puts "Found the user"
    # Your background job logic here
  end
end
