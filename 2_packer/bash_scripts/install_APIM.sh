#!/bin/bash

#git clone https://github.com/Axway/Cloud-Automation
git clone https://github.com/temporarychicken/Cloud-Automation


cd Cloud-Automation/APIM/Helmchart

#find .  \( -type d -name .git -prune \) -o -type f -print0 | xargs -0 sed  -i "s:networking.k8s.io/v1beta1:networking.k8s.io/v1:g w /dev/stdout"

#helm install axwayapimplatform APIM/amplify-apim-7.7-1.3.0.tgz

# Enable local storage path access as a storage class in Kubernetes

#kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml

# Install the Axway APIM platform (local install method)

#helm install axwayapim amplify-apim-7.7 --namespace default -f amplify-apim-7.7/values.local.yaml


helm install axwayapim amplify-apim-7.7 --namespace default --set global.domainName=axwaydomain --set enableDynamicLicense=true

# Remove the empty installed APIM/amplify-apim-7 license file

kubectl delete -n default configmap license

# Install our own valid APIM license file

kubectl apply -f ~/k8s_configuration/k8s_configuration/axway_license_configmap.yaml
