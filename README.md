# Docker Django Boilerplate

Sample setup for a Django project with Docker. 

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


## Useful links

* [Docker Hub Python](https://hub.docker.com/_/python/)
* [Docker Hub Postgres](https://hub.docker.com/_/postgres/)
* [Docker compose Postgres environment variables](http://stackoverflow.com/questions/29580798/docker-compose-environment-variables )
* [Quickstart: Docker Compose and Django](https://docs.docker.com/compose/django/)

 - explain: gitignore, pypi, docker tips
    
    

# License

    Copyright 2016 Maarten Huijsmans

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
