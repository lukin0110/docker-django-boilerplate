# Rename *hello* to *project_name*

For example, your project name will be *mars*.

## in docker-compose.yml

Change:
```
- POSTGRES_DB_NAME=hello
```
to:
```
- POSTGRES_DB_NAME=mars
```

## in directory ./app

Rename *hello* dir to *mars*

## in app/mars/settings.py

Change:
```
ROOT_URLCONF = 'hello.urls'
```
to:
```
ROOT_URLCONF = 'mars.urls'
```

Change:
```
WSGI_APPLICATION = 'hello.wsgi.application'
```
to:
```
WSGI_APPLICATION = 'mars.wsgi.application'
```

## in app/mars/wsgi.py

Change:
```
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "hello.settings")
```
to:
```
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "mars.settings")
```
