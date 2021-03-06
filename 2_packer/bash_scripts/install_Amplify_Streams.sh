#!/bin/bash

# Create a new namespace for Amplify Streams to reside in

kubectl create ns amplify-streams

# Download the Amplify Streams installer

curl -o streams-helm-chart-v2.0.2-2.tar.gz https://packer-build-resources.s3.eu-west-2.amazonaws.com/helm-charts/streams-helm-chart-v2.0.2-2.tar.gz

# Unpack the downloaded archive
tar -xzf streams-helm-chart-v2.0.2-2.tar.gz

#Change into the helm chart master directory
cd streams

#Edit the yaml streams installer config file using automated editor
sed -i 's/host: ""/host: "localhost"/g' values.yaml
sed -i 's/acceptGeneralConditions: "no"/acceptGeneralConditions: "yes"/g' values.yaml

#Install the MariaDB secret
export NAMESPACE="amplify-streams"
export MARIADB_ROOT_PASSWORD="my-mariadb-root-password"
export MARIADB_PASSWORD="my-mariadb-user-password"
export MARIADB_REPLICATION_PASSWORD="my-mariadb-replication-password"

kubectl create secret generic streams-database-passwords-secret --from-literal=mariadb-root-password=${MARIADB_ROOT_PASSWORD} --from-literal=mariadb-password=${MARIADB_PASSWORD}  --from-literal=mariadb-replication-password=${MARIADB_REPLICATION_PASSWORD} -n ${NAMESPACE}

#Install the docker registry from which we will obtain the streams application images
export NAMESPACE="amplify-streams"
export REGISTRY_SECRET_NAME="my-registry-secret-name"
export REGISTRY_SERVER="docker.repository.axway.com"
export REGISTRY_USERNAME="dluke_a2275336-f9b1-42a5-87a1-8908abf209fb"
export REGISTRY_PASSWORD="58d9c8e8-bb0c-46bd-b69d-42ad298c68fe"

kubectl create secret docker-registry "${REGISTRY_SECRET_NAME}" --docker-server="${REGISTRY_SERVER}"  --docker-username="${REGISTRY_USERNAME}" --docker-password="${REGISTRY_PASSWORD}" -n "${NAMESPACE}"



#Install Amplify Streams using Helm
helm install "streams" . -f values.yaml -n amplify-streams \
--set embeddedMariadb.tls.enabled=false \
--set embeddedMariadb.encryption.enabled=false \
--set embeddedMariadb.master.extraEnvVarsSecret=null \
--set embeddedMariadb.slave.extraEnvVarsSecret=null \
--set embeddedKafka.auth.clientProtocol=plaintext \
--set embeddedKafka.auth.interBrokerProtocol=plaintext \
--set embeddedKafka.auth.sasl.mechanisms=plain \
--set embeddedKafka.auth.sasl.interBrokerMechanism=plain \
--set embeddedKafka.auth.sasl.jaas.clientPasswordSecret=null \
--set embeddedKafka.extraEnvVars=null \
--set embeddedKafka.extraVolumes=null \
--set embeddedKafka.extraVolumeMounts=null \
--set imagePullSecrets[0].name="${REGISTRY_SECRET_NAME}" \
--set images.repository="docker.repository.axway.com/axwaystreams-docker-prod-ptx/2.0"

kubectl apply -f ~/bash_scripts/nginx_streams_ingress_service_2.yaml


