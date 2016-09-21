FROM signmeup/meteord:base
MAINTAINER SignMeUp

ONBUILD COPY ./ /app
ONBUILD RUN bash $METEORD_DIR/on_build.sh
