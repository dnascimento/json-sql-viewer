FROM postgres

ENV PGADMIN_VERSION=3.3

RUN apt-get update && apt-get install -y python-setuptools python-dev build-essential ca-certificates python3-pip git python-psycopg2 libpq-dev python-dev
RUN easy_install pip

RUN echo "https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v${PGADMIN_VERSION}/pip/pgadmin4-${PGADMIN_VERSION}-py2.py3-none-any.whl" | pip install --no-cache-dir -r /dev/stdin

RUN  mkdir -p /pgadmin/config /pgadmin/storage \
    && chown -R postgres /pgadmin

RUN pip3 install -e git+https://github.com/better/jsonschema2db#egg=jsonschema2db
COPY config_distro.py /usr/local/lib/python2.7/dist-packages/pgadmin4/
ADD entrypoint.sh .
USER postgres
ENTRYPOINT ["/entrypoint.sh"]
ADD jsondb.py .
