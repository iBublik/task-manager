# Test task for VoltMobi

[![Build Status](https://travis-ci.org/iBublik/volt-mobi.svg?branch=master)](https://travis-ci.org/iBublik/volt-mobi)

## Project setup

1. Copy config files:

        $ cp config/database.yml.example config/database.yml
        $ cp config/secrets.yml.example config/secrets.yml

2. Install and run bundler

        $ gem install bundler
        $ bundle

3. Create and prepare database

        $ rake db:setup
        $ # or
        $ rake db:create
        $ rake db:migrate
        $ rake db:seed

4. Install git hooks

        $ overcommit --install
