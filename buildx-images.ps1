$AUTHOR="carlesbarreda"
$PROJECT="certbot"
$VERSION="1.0.0"

$IMAGE_NAME="${AUTHOR}/${PROJECT}"
$IMAGE_TAG="${VERSION}"
$IMAGE="${IMAGE_NAME}:${IMAGE_TAG}"

docker context create --from default ${PROJECT}
docker buildx create --use --name firebird --driver docker-container ${PROJECT}
docker buildx use ${PROJECT}
docker buildx build --platform linux/amd64,linux/386,linux/arm64,linux/arm/v7 --tag ${IMAGE} --tag "${IMAGE_NAME}:latest" --push --file ./Dockerfile .
#docker buildx build --platform linux/386,linux/arm64,linux/arm/v7 --tag ${IMAGE} --tag "${IMAGE_NAME}:latest" --push --file ./Dockerfile .