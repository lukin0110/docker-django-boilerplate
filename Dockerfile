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
    postgresql-client dos2unix && \
    rm -rf /var/lib/apt/lists/*

# Set the default workdir
WORKDIR /usr/src/app

# Copy deployment files
# Adding requirements.txt & uwsgi.ini
COPY deployment/requirements.txt deployment/uwsgi.ini /deployment/
RUN pip install -r /deployment/requirements.txt

# Add the entrypoint.sh
COPY deployment/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN dos2unix /usr/local/bin/docker-entrypoint.sh && \
    chmod a+x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

# Add the project source
COPY app .

RUN ./manage.py collectstatic --noinput

# Run uWSGI by default
CMD ["uwsgi"]
