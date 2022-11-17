#!/usr/bin/env bash

# Requires: curl, zsh, unzip

OS=""
if [ "$(uname)" == "Darwin" ]; then
    OS="mac"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    OS="linux"
fi
if test "${OS}" != "linux"; then
    echo "Only Linux supported."
    exit 1
fi

VER="v1.24.4+k0s.0"

echo "Fetching K0s..."
curl -sSLf https://get.k0s.sh | sudo K0S_VERSION="${VER}" sh
echo "Installing single node controller..."
sudo k0s install controller --single
echo "Starting Kubernetes..."
sudo k0s start
echo "Configuring local kubeconfig..."
mkdir -p $HOME/.kube
sudo k0s kubeconfig admin > $HOME/.kube/config && chmod 600 $HOME/.kube/config
echo "Done."
