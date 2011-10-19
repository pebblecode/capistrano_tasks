# Capistrano Tasks

This a repo to hold commonly used Capistrano Tasks at pebble {code}

## Conventions

If you have specific scripts for Rails versions please add them under

* rails.3.1.x
* rails.3.0.x
* rails.2.x.x

Within each folder is a `deploy.rb` file which is the base file for the project. We are assuming capistrano multistage is being used.

Add recipes for scenarios like thin, passenger or your latest greatest thing under folders.

If you don't like the conventions for the project and suggest new ones.

