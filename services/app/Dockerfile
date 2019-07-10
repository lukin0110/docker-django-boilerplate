#
# Minimal Docker image for a Django project
#
FROM python:3.7.4-alpine3.10

# Ensure that Python outputs everything that's printed inside
# the application rather than buffering it.
ENV PYTHONUNBUFFERED 1

# Include codebase in the PYTHONPATH
ENV PYTHONPATH $PYTHONPATH:/usr/src/

# Set the default workdir
WORKDIR /usr/src/app

# Django port & uWSGI stats port
EXPOSE 8000 8001

# Install system packages
# eg: PostgreSQL client, git, gettext
RUN apk add --no-cache --virtual .build-deps \
    ca-certificates gcc g++ bash linux-headers musl-dev \
    curl-dev libressl-dev git \
    postgresql-dev postgresql-client gettext

# Copy deployment files
# Adding requirements.txt & uwsgi.ini
COPY services/app/requirements.txt services/app/uwsgi.ini /deployment/
RUN pip install -r /deployment/requirements.txt

# Add the entrypoint.sh
COPY services/app/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN dos2unix /usr/local/bin/entrypoint.sh && \
    chmod a+x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Add the project source
COPY app .

# Explicitly run the manage.py with python, without it doesn't work on some windows versions
RUN python manage.py collectstatic --noinput

# Run uWSGI by default
CMD ["uwsgi"]
