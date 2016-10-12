# Docker Django Boilerplate

Minimal setup for a Django project with Docker. This repo contains 
skeleton code to get up and running with Docker & Django quickly. The 
image uses [uWSGI](https://uwsgi-docs.readthedocs.io/) to host the 
Django project. It's up to you to put Nginx or Apache in front in 
production.  

The image contains the *hello* Django project. 
[Replace the word *hello* with the name of *your project*](docs/rename.md).

## Usage

Download the repository:
```
$ git clone https://github.com/lukin0110/docker-django-boilerplate.git
```

Init project:
```
$ cd docker-django-boilerplate
$ docker-compose build
```

Setup database:
```
$ docker-compose up -d postgres
$ docker-compose run app setup_db
```

Launch:
```
$ docker-compose up app
```

## Container commands

The image has 

Run a command:
```
$ docker-compose run app <command>
```

Available commands:

| Command   | Description                                                                     |
|-----------|---------------------------------------------------------------------------------|
| dev       | Start a normal Django development server                                        |
| bash      | Start a bash shell                                                              |
| manage    | Start manage.py                                                                 |
| setup_db  | Setup the initial database. Configure *$POSTGRES_DB_NAME* in docker-compose.yml |
| lint      | Run pylint                                                                      |
| python    | Run a python command                                                            |
| shell     | Start a Django Python shell                                                     |
| uwsgi     | Run uwsgi server                                                                 |
| help      | Show this message                                                               |

### Create a Django app

```
$ docker-compose run app manage startapp myapp
```

### Create a super user
```
$ docker-compose run app manage createsuperuser
```

## Useful links

* [Docker Hub Python](https://hub.docker.com/_/python/)
* [Docker Hub Postgres](https://hub.docker.com/_/postgres/)
* [Docker compose Postgres environment variables](http://stackoverflow.com/questions/29580798/docker-compose-environment-variables)
* [Quickstart: Docker Compose and Django](https://docs.docker.com/compose/django/)
