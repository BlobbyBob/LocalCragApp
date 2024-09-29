FROM python AS localcragapp-server
RUN pip install pipenv
ENV PYTHONPATH=/localcragapp/src
RUN mkdir /.local && chown 1000:1000 /.local
RUN echo '#!/usr/bin/env bash' >> /bin/test-server && \
    echo 'LOCALCRAG_CONFIG=config/test-ci.cfg SQLALCHEMY_DATABASE_URI=${SQLALCHEMY_DATABASE_URI}_test exec pipenv run pytest ${1:-"/localcragapp/tests"}' >> /bin/test-server && \
    chmod +x /bin/test-server
USER 1000:1000
WORKDIR /localcragapp
COPY ./server/Pipfile /localcragapp/Pipfile
COPY ./server/Pipfile.lock /localcragapp/Pipfile.lock
RUN pipenv install
WORKDIR /localcragapp/src

FROM node AS localcragapp-client
USER 1000:1000
WORKDIR /localcragapp
COPY ./client .
RUN npm ci

FROM postgres AS localcragapp-database
RUN apt update && \
    apt install -y netcat-traditional && \
    rm -rf /var/lib/apt/lists/*
RUN echo '#!/usr/bin/env bash' >> /setup.sh && \
    echo '/restore-db.sh &' >> /setup.sh && \
    echo 'source /usr/local/bin/docker-entrypoint.sh' >> /setup.sh && \
    echo '_main "$@"' >> /setup.sh && \
    chmod +x /setup.sh
RUN echo '#!/usr/bin/env bash' >> /restore-db.sh && \
    echo 'while true; do' >> /restore-db.sh && \
    echo '    nc -u -l -p 5433 &>/dev/null' >> /restore-db.sh && \
    echo '    [ -f /dump.sql ] && pg_restore --no-privileges --no-owner --clean --create -U $POSTGRES_USER -d localcrag_test /dump.sql' >> /restore-db.sh && \
    echo ' done' >> /restore-db.sh && \
    chmod +x /restore-db.sh
ENTRYPOINT ["/setup.sh"]
CMD ["postgres"]