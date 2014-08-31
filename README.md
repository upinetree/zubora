# Zubora

Kakeibo for Zubora-san (WIP)

demo: http://zubora.herokuapp.com/sessions/new

## Getting Started

```
$ bundle install
$ bower install
$ rake db:create db:migrate
$ rails server
```

## Deployment

### Demo

```
$ heroku config:set RACK_ENV=demo RAILS_ENV=demo
$ heroku config:set BUILDPACK_URL=git://github.com/qnyp/heroku-buildpack-ruby-bower.git#run-bower
$ git push heroku master
$ heroku run rake db:migrate
```

