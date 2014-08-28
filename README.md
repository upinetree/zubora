# Zubora

## Getting Started

```
bundle install
rake db:create db:migrate
rails server
```

## Deployment

### Demo

```
heroku config:set RACK_ENV=demo RAILS_ENV=demo
git push heroku master
heroku run rake db:migrate
```

