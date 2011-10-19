#---------------------------
# pebble {code} Base Capistrano Script for Rails 3.1 projects
# https://github.com/pebblecode/capistrano_tasks
#---------------------------

#---------------------------
# Multistage support for Capistrano
# requires 'capistrano-ext' gem
#---------------------------
require 'capistrano/ext/multistage'

#---------------------------
# Define Capistrano stages
#---------------------------
set :stages, %w(production staging)
set :default_stage, "staging"

#---------------------------
# We are using bundler so let Capistrano know
# requires 'bundler' gem
#---------------------------
require 'bundler/capistrano'

#---------------------------
# Git stuff
#---------------------------
set :repository,  "git@yourrepo.com:yourapp.com.git"
set :scm, :git
set :deploy_via, :remote_cache
set :keep_releases, 3 
default_run_options[:pty] = true

#---------------------------
# Track deployment via airbreak
# requires 'airbreak' gem
#---------------------------
require 'airbrake/capistrano'
