#
# Minimal Docker image for a Django project
#
FROM python:3.5

# Ensure that Python outputs everything that's printed inside
# the application rather than buffering it.
ENV PYTHONUNBUFFERED 1

# Install the PostgreSQL client
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    postgresql-client && \
    rm -rf /var/lib/apt/lists/*

# Set the default workdir
WORKDIR /usr/src/app

# Used by docker-entrypoint.sh to start the dev server
# If not configured you'll receive this: CommandError: "0.0.0.0:" is not a valid port number or address:port pair.
ENV PORT 8000

# Install the requirements
COPY deployment/requirements.txt ./
RUN pip install -r requirements.txt

# Add uwsgi.ini file to the root. The entrypoint starts uwsgi from the root
COPY deployment/uwsgi.ini /

# Add the entrypoint.sh
COPY deployment/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

# Add the project source
COPY app .

RUN ./manage.py collectstatic --noinput

# Run uWSGI by default
CMD ["uwsgi"]
