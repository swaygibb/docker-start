FROM ruby:2.6
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /parts-api
WORKDIR /parts-api

ENV BUNDLE_PATH /box
ENV GEM_PATH /box
ENV GEM_HOME /box

COPY Gemfile /parts-api/Gemfile
COPY Gemfile.lock /parts-api/Gemfile.lock
RUN bundle install
COPY . /parts-api

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]