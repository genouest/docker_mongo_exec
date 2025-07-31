FROM mongo:8.0.12

USER root

RUN apt-get -q update \
    && DEBIAN_FRONTEND=noninteractive apt-get -yq --no-install-recommends install \
        python3 python3-pip python-is-python3 git python3-pymongo acl \
    && rm -rf /var/lib/apt/lists/*

ADD entrypoint.sh /
ADD /scripts/ /scripts/

ENV RUN_USER='mongodb' \
    MONGO_USER='mongodb'

ENTRYPOINT ["/entrypoint.sh"]
