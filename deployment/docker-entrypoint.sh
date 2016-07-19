#!/bin/bash
set -e

# Define help message
show_help() {
    echo """
Usage: docker run <imagename> COMMAND

Commands

dev     : Start a normal Django development server.
bash    : Start a bash shell
lint    : Run pylint
python  : Run a python command
shell   : Start a Django Python shell.
uwsgi   : Run uwsgi server.
help    : Show this message
"""
}

# Run
case "$1" in
    dev)
        echo "Running Development Server..."
        python manage.py runserver 0.0.0.0:${PORT}
    ;;
    bash)
        /bin/bash "${@:2}"
    ;;
    manage)
        python manage.py "${@:2}"
    ;;
    lint)
        pylint "${@:2}"
    ;;
    python)
        python "${@:2}"
    ;;
    shell)
        python manage.py shell_plus
    ;;
    uwsgi)
        echo "Running App (uWSGI)..."
        uwsgi --ini /deployment/uwsgi.ini
    ;;
    *)
        show_help
    ;;
esac
