#!/usr/bin/python
"""
Replaces the 'hello' project with your 'project name'. It will replace the necessary settings in a
few files.
"""
import os


def replace(file, old, new):
    with open(file) as f:
        new_text = f.read().replace(old, new)

    with open(file, "w") as f:
        f.write(new_text)


def handle(project_name):
    replace("docker-compose.yml",
            "POSTGRES_DB_NAME=hello",
            "POSTGRES_DB_NAME={0}".format(project_name))

    replace("app/manage.py",
            'os.environ.setdefault("DJANGO_SETTINGS_MODULE", "hello.settings")',
            'os.environ.setdefault("DJANGO_SETTINGS_MODULE", "{0}.settings")'.format(project_name))

    replace("app/hello/settings.py",
            "ROOT_URLCONF = 'hello.urls'",
            "ROOT_URLCONF = '{0}.urls'".format(project_name))

    replace("app/hello/settings.py",
            "WSGI_APPLICATION = 'hello.wsgi.application'",
            "WSGI_APPLICATION = '{0}.wsgi.application'".format(project_name))

    replace("app/hello/wsgi.py",
            'os.environ.setdefault("DJANGO_SETTINGS_MODULE", "hello.settings")',
            'os.environ.setdefault("DJANGO_SETTINGS_MODULE", "{0}.settings")'.format(project_name))

    # Rename the 'hello' dir to 'your_project'
    os.rename("app/hello", "app/{0}".format(project_name))


if __name__ == "__main__":
    name = raw_input("Project name: ")
    handle(name)
