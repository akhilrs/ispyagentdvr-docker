#!/bin/sh

set -e

DOCKER_BAKE_FILE=${1:-"docker-bake.hcl"}
TAGS=${TAGS:-"3.1.3.0"}
FILE_LOCATION=${FILE_LOCATION:-"https://ispyfiles.azureedge.net/downloads/Agent_Linux64_3_1_3_0.zip"}
DEFAULT_FILE_LOCATION=${DEFAULT_FILE_LOCATION:-"https://www.ispyconnect.com/api/Agent/DownloadLocation2?productID=24&is64=true&platform=Linux"}
TZ=${TZ:-"Asia/Kolkata"}
PLATFORMS=${PLATFORMS:-"linux/amd64 linux/arm64"}
IMAGE_NAME=${IMAGE_NAME:-"akhilrs/ispyagentdvr"}

cd "$(dirname "$0")"

MAIN_TAG=${TAGS%%" "*} # First tag
TAGS_EXTRA=${TAGS#*" "} # Rest of tags
P="\"$(echo $PLATFORMS | sed 's/ /", "/g')\""

T="\"$(echo $MAIN_TAG)\", \"$(echo $TAGS_EXTRA | sed 's/ /", "/g')\""



cat > "$DOCKER_BAKE_FILE" << EOF
group "default" {
	targets = [$T]
}
target "common" {
	platforms = [$P]
	args = {"FILE_LOCATION" = "$FILE_LOCATION", "DEFAULT_FILE_LOCATION" = "$DEFAULT_FILE_LOCATION", "TZ" = "$TZ"}
    dockerfile = "Dockerfile"
}
target "latest" {
    inherits = ["common"]
    tags = ["$IMAGE_NAME:latest"]
}
EOF

for TAG in $TAGS_EXTRA; do cat >> "$DOCKER_BAKE_FILE" << EOF
target "$TAG" {
  inherits = ["common"]
  tags = ["$IMAGE_NAME:$TAG"]
}
EOF
done