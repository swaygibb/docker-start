docker-compose run web rails new . --force --no-deps

docker-compose build

Replace config/database.yml with the following

------------

default: &default
  adapter: postgresql
  encoding: unicode
  host: db
  username: postgres
  password:
  pool: 5

development:
  <<: *default
  database: myapp_development


test:
  <<: *default
  database: myapp_test

------------

docker-compose up

docker-compose run web rake db:create


Restart the application

To restart the application run docker-compose up in the project directory.
Rebuild the application

If you make changes to the Gemfile or the Compose file to try out some different configurations, you need to rebuild. Some changes require only docker-compose up --build, but a full rebuild requires a re-run of docker-compose run web bundle install to sync changes in the Gemfile.lock to the host, followed by docker-compose up --build.

Here is an example of the first case, where a full rebuild is not necessary. Suppose you simply want to change the exposed port on the local host from 3000 in our first example to 3001. Make the change to the Compose file to expose port 3000 on the container through a new port, 3001, on the host, and save the changes:

ports: - "3001:3000"

Now, rebuild and restart the app with docker-compose up --build.

Inside the container, your app is running on the same port as before 3000, but the Rails Welcome is now available on http://localhost:3001 on your local host.