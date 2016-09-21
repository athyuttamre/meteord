echo "=> Preparing to start app..."

set -e

if [ -d /bundle ]; then
  cd /bundle
  tar xzf *.tar.gz
  cd /bundle/bundle/programs/server/
  npm i
  cd /bundle/bundle/
elif [[ $BUNDLE_URL ]]; then
  cd /tmp
  curl -L -o bundle.tar.gz $BUNDLE_URL
  tar xzf bundle.tar.gz
  cd /tmp/bundle/programs/server/
  npm i
  cd /tmp/bundle/
elif [ -d /built_app ]; then
  cd /built_app
elif [[ $METEORD_VOLBUILD ]]; then
  cd /app
else
  echo "=> You don't have an meteor app to run in this image."
  exit 1
fi

if [[ $REBUILD_NPM_MODULES ]]; then
  if [ -f /opt/meteord/rebuild_npm_modules.sh ]; then
    cd programs/server
    bash /opt/meteord/rebuild_npm_modules.sh
    cd ../../
  else
    echo "=> Use meteorhacks/meteord:bin-build for binary bulding."
    exit 1
  fi
fi

# Set a delay to wait to start meteor container
if [[ $DELAY ]]; then
  echo "Delaying startup for $DELAY seconds"
  sleep $DELAY
fi

if [[ $METEORD_VOLBUILD ]]; then
  # Default port 80; if ARGS provided, they should include "--port 80"
  export ARGS=${ARGS:---port 80}
  echo "=> Starting meteor app with args: $ARGS"
  meteor $ARGS
else
  # Default port 80; honor an override
  export PORT=${PORT:-80}
  echo "=> Starting meteor app on port:$PORT"
  node main.js
fi
