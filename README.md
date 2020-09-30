# House Market App

[house-market-app](https://mighty-dawn-88051.herokuapp.com/)

- Ruby [2.6.3](https://github.com/klaudiasob/blog/blob/master/.ruby-version#L1)
- Rails [5.2.3](https://github.com/klaudiasob/blog/blob/master/Gemfile#L19)

## Install
#### 1. Check out the repository

```bash
git clone git@github.com:klaudiasob/blog.git
```

#### 2. Install gems

```ruby
bundle install
```

#### 3. Create and setup the database

Run the following commands to setup the database and populate it with seed data.

```ruby
bundle exec rake db:setup
```

#### 4. Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```

And now you can visit the site with the URL http://localhost:3000

#### Test data
You can use following accounts to login into the application:
- email: `owner@example.com`; password: `password`
- email: `buyer@example.com`; password: `password`
- email: `admin@example.com`; password: `password`
