#!/bin/bash
set -e

# Check if the required PostgreSQL environment variables are set

# Used by docker-entrypoint.sh to start the dev server
# If not configured you'll receive this: CommandError: "0.0.0.0:" is not a valid port number or address:port pair.
[ -z "$PORT" ] && echo "ERROR: Need to set PORT. E.g.: 8000" && exit 1;

[ -z "$POSTGRES_DB_NAME" ] && echo "ERROR: Need to set POSTGRES_DB_NAME" && exit 1;
[ -z "$POSTGRES_USER" ] && echo "ERROR: Need to set POSTGRES_USER" && exit 1;
[ -z "$POSTGRES_PASSWORD" ] && echo "ERROR: Need to set POSTGRES_PASSWORD" && exit 1;

# Used by uwsgi.ini file to start the wsgi Django application
[ -z "$WSGI_MODULE" ] && echo "ERROR: Need to set WSGI_MODULE. E.g.: hello.wsgi:application" && exit 1;


# Define help message
show_help() {
    echo """
Usage: docker run <imagename> COMMAND

Commands

dev      : Start a normal Django development server
bash     : Start a bash shell
manage   : Start manage.py
setup_db : Setup the initial database. Configure \$POSTGRES_DB_NAME in docker-compose.yml
lint     : Run pylint
python   : Run a python command
shell    : Start a Django Python shell
uwsgi    : Run uwsgi server
help     : Show this message
"""
}

write_uwsgi() {
    echo "Generating uwsgi config file..."
    snippet="import os;
import sys;
import jinja2;
sys.stdout.write(jinja2.Template(sys.stdin.read()).render(env=os.environ))"

    cat /deployment/uwsgi.ini | python -c "${snippet}" > /uwsgi.ini
}

# Run
case "$1" in
    dev)
        echo "Running Development Server on 0.0.0.0:${PORT}"
        python manage.py runserver 0.0.0.0:${PORT}
    ;;
    bash)
        /bin/bash "${@:2}"
    ;;
    manage)
        python manage.py "${@:2}"
    ;;
    setup_db)
        psql -h $POSTGRES_PORT_5432_TCP_ADDR -U $PGPASSWORD -c "CREATE DATABASE $POSTGRES_DB_NAME"
        python manage.py migrate
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
        write_uwsgi
        uwsgi --ini /uwsgi.ini
    ;;
    *)
        show_help
    ;;
esac
