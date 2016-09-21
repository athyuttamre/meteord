echo "=> Building app..."
echo "${node -v}"
echo "${npm -v}"

set -e

COPIED_APP_PATH=/copied-app
BUNDLE_DIR=/tmp/bundle-dir

# sometimes, directly copied folder cause some wierd issues
# this fixes that
echo "=> Copying /app to $COPIED_APP_PATH"
cp -R /app $COPIED_APP_PATH
cd $COPIED_APP_PATH

echo "=> Installing node_modules"
meteor npm i

echo "=> Building app bundle"
meteor build --directory $BUNDLE_DIR --server=http://localhost:3000

cd $BUNDLE_DIR/bundle/programs/server/
npm i --unsafe-perm

echo "=> Copying app bundle to /built_app"
mv $BUNDLE_DIR/bundle /built_app

# cleanup
echo "=> Cleaning up"
rm -rf $COPIED_APP_PATH
rm -rf $BUNDLE_DIR
rm -rf ~/.meteor
rm /usr/local/bin/meteor
