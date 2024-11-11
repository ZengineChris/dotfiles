#!bin/bash

echo "Setting up a local registry"

DOCKER_STORAGE=$HOME/docker_storage
mkdir -p $DOCKER_STORAGE
cat <<EOF > ${DOCKER_STORAGE}/registry_config.yml
version: 0.1
log:
  fields:
    service: registry
storage:
  delete:
    enabled: true
  cache:
    blobdescriptor: inmemory
  filesystem:
    rootdirectory: /var/lib/registry
http:
  addr: :5000
  headers:
    X-Content-Type-Options: [nosniff]
    Access-Control-Allow-Origin: ['*', 'http://localhost:8080']
    Access-Control-Allow-Methods: ['HEAD', 'GET', 'OPTIONS', 'DELETE']
    Access-Control-Allow-Headers: ['Authorization', 'Accept', 'Cache-Control']
    Access-Control-Max-Age: [1728000]
    Access-Control-Expose-Headers: ['Docker-Content-Digest']
EOF

docker stop registry 2>/dev/null
docker stop registry-ui 2>/dev/null
docker rm registry 2>/dev/null
docker rm registry-ui 2>/dev/null
docker run -d --restart=always -p "0.0.0.0:5000:5000" \
    -v ${DOCKER_STORAGE}:/var/lib/registry \
    -v ${DOCKER_STORAGE}/registry_config.yml:/etc/docker/registry/config.yml \
    --name registry registry

docker run -d --restart=always -p "8080:80" -e DELETE_IMAGES=true -e REGISTRY_TITLE="Localhost Registry" -e REGISTRY_URL="http://localhost:5000" -e SINGLE_REGISTRY=true --name registry-ui joxit/docker-registry-ui:latest

cat <<EOF

Local registry available at http://localhost:8080

After delete, run
   docker exec registry registry garbage-collect /etc/docker/registry/config.yml

EOF
