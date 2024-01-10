# Use the Ruby base image
FROM ruby:3.2.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set the working directory inside the container
WORKDIR /recipes-backend

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile /recipes-backend/Gemfile
COPY Gemfile.lock /recipes-backend/Gemfile.lock

# Install gems
RUN bundle install

# Copy the main application
COPY . /recipes-backend

# Expose the port the server runs on
EXPOSE 3000

# Start the server
CMD ["rails", "server", "-b", "0.0.0.0"]
