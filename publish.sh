
#!/bin/sh

set -e

cd "$(dirname "$0")"


PLATFORMS=${PLATFORMS:-"linux/amd64 linux/arm64 linux/arm/v7"}

P="\"$(echo $PLATFORMS | sed 's/ /", "/g')\""

echo $PLATFORMS


./generate.sh -p="$PLATFORMS"

# docker buildx bake --pull --push 