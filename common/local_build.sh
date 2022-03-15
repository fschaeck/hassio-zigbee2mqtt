USER=${1}
PASSWORD=${2}
ARCH=${3:-amd64}

cd ..
cp common/Dockerfile zigbee2mqtt/
cp -R common/rootfs zigbee2mqtt/

docker run --rm --privileged \
-v $(pwd)/zigbee2mqtt:/data \
-v ~/.docker:/root/.docker \
homeassistant/amd64-builder \
--$ARCH -t /data \
--docker-user "$1" \
--docker-password "$2" \
--no-cache
# -v /var/run/docker.sock:/var/run/docker.sock:ro \
# --test \

rm -rf zigbee2mqtt/rootfs
rm zigbee2mqtt/Dockerfile
