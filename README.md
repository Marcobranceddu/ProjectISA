# DBG Events

Ruby on Rails university project.

## TODO

- [x] ~~Registrazione di utenti~~
- [x] ~~Registrazione di organizzatori~~
- [x] ~~Permettere ad organizzatori di creare eventi~~
- [x] ~~Permettere agli utenti di ricercare eventi~~
- [x] ~~Permettere agli utenti di registrarsi e deregistrarsi da eventi~~
- [x] ~~Impedire ad utenti di registrarsi ad un evento se concomitante ad un altro ai quali sono già iscritti~~
- [x] ~~Permettere agli organizzatori di consultare la lista dei partecipanti ai propri eventi ed eventualmente rimuovere utenti iscritti indesiderati dai propri eventi~~
- [x] ~~Sistema di notifiche per utenti e organizzatori~~
- [x] ~~Possibilità da parte degli organizzatori di inviare messaggi (tramite notifica) a tutti gli iscritti ad un proprio evento~~
- [x] ~~Possibilità degli organizzatori di gestire una blacklist per utenti la quale impedirà agli utenti bannati di iscriversi agli eventi da loro creati~~
- [x] ~~Sistema di chat tra organizzatori ed utenti~~

## Ruby version

Ruby `3.1.1`

Rails `~> 7.0.2`

## System dependencies

The project is dockerized so you only need `Docker` and `docker-compose`.

## Configuration

When creating new files inside the container with the `rails` command, they will be owned by `root`, so you need to fix the permissions for your editor to be able to edit them:

```bash
sudo chown -R $USER:$USER .
```

## Database creation

## Database initialization

Migrate the database:

```bash
docker exec -it <container_name> rails db:migrate
```

## How to run the test suite

## Services (job queues, cache servers, search engines, etc.)

## Deployment instructions

To start the app in development:

```bash
docker-compose up -d
```

To start the app in test:

```bash
docker-compose -f docker-compose.yml -f docker-compose-test.yml up -d
```

To start the app in production:

```bash
docker-compose -f docker-compose.yml -f docker-compose-production.yml up -d
```

Changes to the Gemfile or the Dockerfile, should be the only times you’ll need to:

```bash
docker-compose build
```

bundle exec rubocop -A
