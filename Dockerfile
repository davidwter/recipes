# Use the official Ruby image as a parent image
FROM ruby:3.2.2

# Set the working directory
WORKDIR /usr/src/app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile* ./

# Install dependencies
RUN bundle install

# Copy the rest of your app's source code from your host to your image filesystem.
COPY . .

# Expose the port your app runs on
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
