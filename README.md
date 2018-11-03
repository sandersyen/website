# Chrono [![Build Status](https://travis-ci.org/cs506-chrono/website.svg?branch=master)](https://travis-ci.org/cs506-chrono/website)

## Setting up Dev Environment

*Note:* This can be challenging on Windows; we recommend a Linux or Mac system.

1. Install [Ruby 2.5](https://www.ruby-lang.org/en/downloads/)
2. Use the command `gem install bundler` to install bundler, which we use to manage dependencies
4. Use the command `bundle install`* from inside the project directory to install all required dependencies

*If you run in to an issue with `bundle install` related to `pg`, try running `bundle install --without production` instead.

## Running the Server

1. Create the database and necessary tables with `rake db:migrate`
2. Run the server with `rails server`
3. Open `http://localhost:3000` in your browser

## Running Tests

We have separate command for particular tests (the system tests require a web driver):

* Execute `rake test` to run normal tests
* Install [ChromeDriver](http://chromedriver.chromium.org/) and run `rake test:system` to run Selenium tests\

