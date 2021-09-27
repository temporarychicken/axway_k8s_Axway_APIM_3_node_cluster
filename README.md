# Axway Kubernetes Workshop - Build a K8S cluster from zero, optionally with Axway APIM and Istio Service Mesh
![alt text](https://www.axway.com/sites/default/files/2019-09/axway.png "Logo Title Text 1")

## Introduction

This workshop creates Kubernetes demo environment that is instantiated in AWS. The key technologies used are Packer, Terraform, Ansible, and bash.

The workshop consists of a fully working OpenSource Kubernetes 3-node cluster (one master, 2 worker-nodes) and the following applications:
* NGINX ingress controller
* Axway API Management - Includes API Manager, API Gateway, and Node Manager

The entire workshop installs and instantiates with the steps below, and will use the latest available version for all open-source and commercial software included.

## Prerequisites

* Access to an AWS account, together with the programatic access credentials as per the following shell variables:
```
    export AWS_ACCESS_KEY_ID=""
    export AWS_SECRET_ACCESS_KEY=""
    export AWS_SESSION_TOKEN=""
 ```
 
* The aws CLI tool version 2, available here:
           https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html 
* Packer - a shell command line tool, install from here:
        https://www.packer.io/docs/install/
* Terraform - a shell command line tool, install from here:
        https://learn.hashicorp.com/terraform/getting-started/install.html
 * A domain name registration within AWS Route 53. This can be any domain name of your choosing, the default will be axwaydemo.net which is registered and owned by Axway.
 * The git command line tool. This can be installed from the relevant repo within your linux distro.

## Instructions

With the above pre-requisites in place execute the following steps to instantiate the demo workshop:

1. Clone this git repository onto your workstation. This will create a copy of the workshop locally:

```
          git clone https://github.com/temporarychicken/axway_k8s_Axway_APIM_3_node_cluster
```

2. cd into the newly created axway_APIM_kubernetes directory

3. Run the initiation script configure_workshop_name_XXXXXXX.sh and enter a subdomain name for your workshop. This must be unique to you, since there may be several other workshops running concurrently. Just stick to lower-case letters and numbers, a good example would be: fredblogs

The two scripts below support various operating systems, be sure to use the correct one to change the subdomain name from the default:
```
configure_workshop_name_GNU_Linux.sh
configure_workshop_name_MACOS_Linux.sh

```

4. cd into the step 1_terraform-create-or-refresh-certs directory. This will enable you to create some TLS Certificates for your new domain, which will be, for example, ***fredblogs.axwaydemo.net***

8. Apply the terraform plan to create your certificates and keys. You'll get a wildcard cert for your domain, an intermediate cert to tie it back to the root CA, and also a private key.
```
./create_certs.sh
```
9. Your certs and key will now be visible in a new 'certs' directory.
10. The next step is to build your base docker machine. This will be based on an existing CentOS image from AWS, but with docker installed ready for instantiation into a fully working kubernetes system at the next stage.

NOTE: Once this base machine is built it will be stored in the AWS AMI store. You won't need to build it again unless you wish to update the base machine. Stage 3 (terraform) can be created and destroyed as many times as you like without requiring stage 2 again. This is true for any subdomain.
```
cd ../2_packer
packer build pack_k8s_base_docker_machine.json
```
11. Once your  Docker base-machine is built, you can terraform the entire kubernetes cluster using stage 3_terraform
```
cd ../3_terraform
./create_cluster_with_APIM.sh
```
12. You now should have, after approximately 5 minutes - a fully working 3 node kubernetes cluster.

13. When you have finished working with the workshop be sure to tear down your workshop with:
```
./destroy_k8s_cluster.sh
```
## Accessing your Kubernetes system

Now that you have your Kubernetes Cluster up and running in AWS, you can log onto the kubernetes dashboard and see the platform running in the default namespace. Log into the link below, use the access token (a very long on,e so you'll need to copy and paste) that was printed out at the end of the terraform run.

This will be https://k8sdashboard.kubernetes0004.axwaydemo.net/#/login

Don't forget to change the above subdomain (kubernetes0004) into whatever you chose in stage 3.

If you require command line access to your kubernetes system for any reason, such as to use the ***kubectl***  or ***helm*** commands, use the following commands to log into your k8s control node:

```
# Remove any previous cached key for the domain
ssh-keygen -R k8s-master.kubernetes0004.axwaydemo.net
# Connnect to the K8s master node
ssh -i ~/.ssh/k8s-key.pem centos@k8s-master.kubernetes0004.axwaydemo.net
```
Again, don't forget to substitute the subdomain for whatever you chose in stage 3.

## Using the Axway APIM within Kubernetes
You should now have a fully working APIM system within your kubernetes cluster. You can access it with the following links:

Axway API Manager:		https://apimanager.kubernetes0004.axwaydemo.net/home
API Gateway Manager:	https://apigateway.kubernetes0004.axwaydemo.net/login/
API traffic:			https://api.kubernetes0004.axwaydemo.net/

Have fun!