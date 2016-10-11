#!/bin/bash
set -e

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

# Check if the required PostgreSQL environment variables are set
[ -z "$POSTGRES_DB_NAME" ] && echo "ERROR: Need to set POSTGRES_DB_NAME" && exit 1;
[ -z "$POSTGRES_USER" ] && echo "ERROR: Need to set POSTGRES_USER" && exit 1;
[ -z "$POSTGRES_PASSWORD" ] && echo "ERROR: Need to set POSTGRES_PASSWORD" && exit 1;

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
        uwsgi --ini /uwsgi.ini
    ;;
    *)
        show_help
    ;;
esac
