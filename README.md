# Gamerverse

A website that aims to help gamers discover new games, especially ones that are being played in their local area. Gamerverse will make it simple and easy to meet new local gamers, as well as setting up and attending local gaming events.

## Instructions

### Development

Run the application in the development environment (AWS Cloud9):

    rails db:migrate RAILS_ENV=development
    rails db:seed
    rails s -b $IP -p $PORT

### Production

Run the application in the production environment (Heroku):

    git push heroku master
    heroku restart -a gamerverse && heroku pg:reset DATABASE --confirm gamerverse && heroku rake db:migrate && heroku rake db:seed
