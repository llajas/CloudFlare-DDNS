# Use the official Ruby image as the base image
FROM ruby:3.0.0-alpine

# Set the working directory within the container
WORKDIR /app

# Install build tools and libraries needed for native extensions
RUN apk add --update --no-cache \
    build-base \
    libxml2-dev \
    libxslt-dev

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install the gems specified in the Gemfile
RUN bundle install

# Copy the rest of your application's code into the container
COPY . .

# The default command to run when the container starts
CMD ["ruby", "ddns.rb"]

