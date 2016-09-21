FROM signmeup/meteord:base
MAINTAINER SignMeUp

ONBUILD ENV METEORD_VOLBUILD=true

ONBUILD RUN bash $METEORD_DIR/lib/install_meteor.sh
ONBUILD VOLUME /app
