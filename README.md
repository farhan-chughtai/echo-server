# Readme

##### 1. Install

```bash
bundle install
```

##### 2. Create and setup the database

Run the following commands to create and setup the database.
Set the username and password in database.yml file accordingly

```ruby
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:migrate RAILS_ENV=test if needed
```

##### 3. Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```

And now you can visit the site with the URL http://localhost:3000

##### 4. Run the test cases

You can run the test cases using the command given below.

```ruby
bundle exec rails test
```