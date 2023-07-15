# Use a Ruby 2.3.18 base image
FROM ruby:3.2.2-slim

# Set the working directory in the container
WORKDIR /app

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Copy Gemfile and Gemfile.lock to the container
COPY Gemfile* /app/

# Install gems
RUN bundle install

# Copy the entire Rails app to the container
COPY . /app/

# Set environment variables
ENV RAILS_ENV development
ENV RAILS_SERVE_STATIC_FILES true

# Precompile assets
RUN bundle exec rake assets:precompile

# Run database migrations
# RUN bundle exec rake db:migrate

# Expose port 3000
EXPOSE 3001

# Start the Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3001"]
