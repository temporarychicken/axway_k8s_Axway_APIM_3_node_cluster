#!/bin/bash

# INSTALL NGINX INGRESS CONTROLLER (OPENSOURCE) USING HELM PACKAGE MANAGER

helm repo add nginx-stable https://helm.nginx.com/stable
helm repo update
helm install my-release nginx-stable/nginx-ingress

