
#!/bin/sh

set -e

cd "$(dirname "$0")"
./generate.sh

docker buildx bake --pull --push