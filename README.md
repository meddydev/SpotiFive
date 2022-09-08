# SpotiFive

<img src="https://img.shields.io/badge/Spotify-1ED760?&style=for-the-badge&logo=spotify&logoColor=white">
<img src="https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white"> <img src="https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white">
<img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black">
<img src="https://img.shields.io/badge/HTML-239120?style=for-the-badge&logo=html5&logoColor=white">
<img src="https://img.shields.io/badge/CSS-239120?&style=for-the-badge&logo=css3&logoColor=white">
<img src="https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white">
<img src="https://img.shields.io/badge/Heroku-430098?style=for-the-badge&logo=heroku&logoColor=white">

Here is our third group project for the Makers Academy bootcamp where we decided to make a competitive web based game leverage Spotify's public API

## View here!

<insert link to app ...horuku link?>

## Meet the team!

- https://github.com/IrinaVi
- https://github.com/meddydev
- https://github.com/aeghosa
- https://github.com/shaunywho

## It uses:

- [RubyonRails](https://rubyonrails.org/) is a server-side web application framework written in Ruby.
- [PostgresSQL](https://www.postgresql.org/) to model objects in a SQL database.
- [ESLint](https://eslint.org) for linting.
- [Capybara](https://teamcapybara.github.io/capybara/) for testing.
- [RSpec](hhttps://rspec.info//) for end-to-end testing.
<!-- - [Heroku](www.heroku.com) for hosting the app remotely. -->

## Card wall

[You can find the planning board here] (https://trello.com/b/9jnW7ESu/spotifive)

[You can find the engineering project outline here.](https://github.com/makersacademy/course/tree/master/engineering_projects/rails)

## Quickstart

First, clone this repository. Then:

```bash
> bundle install
> bin/rails db:create
> bin/rails db:migrate

> bundle exec rspec # Run the tests to ensure it works
> bin/rails server # Start the server at localhost:3000
```

## Troubleshooting

If you don't have Node.js installed yet, you might run into this error when running rspec:

```
ExecJS::RuntimeUnavailable:
  Could not find a JavaScript runtime. See https://github.com/rails/execjs for a list of available runtimes.
```

That is because Rails will use a Javascript runtime (such as Node) under the hood. The easiest way is to install Node by running `brew install node` -
and then run `bundle exec rspec` again

# Setting up your Spotify Api Key

The App requires the server to be provided with a client_id and a client_secret which can be obtained through the dashboard of spotify's developer page. These are account specific and need to be set before Rails is run. These settings are stored in the config/credentials.yml file. This will be encrypted if you have just pulled from the repository. Run

```
EDITOR="code --wait" bin/rails credentials:edit
```

In the terminal and make adjustments to the yml file before closing the text editor window, the credentials.yml file will now be encrypted and a config/master.key file will have been created. The master key allows you to decrypt the credentials.yml file so ensure that this is not pushed to the repository.
