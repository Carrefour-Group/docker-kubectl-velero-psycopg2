FROM python:3.8-slim

ARG KUBECTL_VERSION=v1.20.0
ARG VELERO_VERSION=v1.7.2

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /app

RUN \
  apt-get update && \
  apt-get install -y wget && \
  wget -q https://github.com/vmware-tanzu/velero/releases/download/${VELERO_VERSION}/velero-${VELERO_VERSION}-linux-amd64.tar.gz && \
  tar zxvf velero-${VELERO_VERSION}-linux-amd64.tar.gz && \
  chmod +x velero-${VELERO_VERSION}-linux-amd64/velero && \
  mv velero-${VELERO_VERSION}-linux-amd64/velero /usr/local/bin && \
  wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
  chmod +x kubectl  && \
  mv kubectl /usr/local/bin && \
  apt-get remove --purge -y wget && \
  rm -rf /var/lib/apt/lists/*

COPY requirements.txt /app
RUN \
  pip3 install -r /app/requirements.txt && \
  rm -f /app/requirements.txt
