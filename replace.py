#!/usr/bin/python
"""
Replaces the 'hello' project with your 'project name'. It will replace the necessary settings in a
few files.
"""
import os


def replace(file: str, old: str, new: str):
    with open(file) as f:
        new_text = f.read().replace(old, new)

    with open(file, "w") as f:
        f.write(new_text)


def handle(name: str):
    replace("docker-compose.yml",
            "POSTGRES_DB_NAME=hello",
            "POSTGRES_DB_NAME={0}".format(name))

    replace("app/hello/settings.py",
            "ROOT_URLCONF = 'hello.urls'",
            "ROOT_URLCONF = '{0}.urls'".format(name))

    replace("app/hello/settings.py",
            "WSGI_APPLICATION = 'hello.wsgi.application'",
            "WSGI_APPLICATION = '{0}.wsgi.application'".format(name))

    replace("app/hello/wsgi.py",
            'os.environ.setdefault("DJANGO_SETTINGS_MODULE", "hello.settings")',
            'os.environ.setdefault("DJANGO_SETTINGS_MODULE", "{0}.settings")'.format(name))

    replace("deployment/uwsgi.ini",
            "module=hello.wsgi:application",
            "module={0}.wsgi:application".format(name))

    # Rename the 'hello' dir to 'your_project'
    os.rename("app/hello", "app/{0}".format(name))

name = input("Project name: ")
handle(name)
