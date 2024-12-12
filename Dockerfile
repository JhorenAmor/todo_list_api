# Use an official Ruby runtime as a parent image
FROM ruby:3.3.0

# Set the working directory in the container
WORKDIR /app

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev

# Install Rails
RUN gem install rails

# Install bundler
RUN gem install bundler

# Add the Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install Ruby gems
RUN bundle install

# Copy the rest of the application code
COPY . .

# Copy the entrypoint script and give it execute permissions
COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

# Expose the port the app runs on (typically 3000 for Rails)
EXPOSE 3000

# Set the entrypoint to run the script
ENTRYPOINT ["/usr/bin/entrypoint.sh"]