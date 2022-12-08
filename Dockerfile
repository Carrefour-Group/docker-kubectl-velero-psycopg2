FROM python:3.12.0a3-slim

ARG DEBIAN_FRONTEND=noninteractive
ARG KUBECTL_VERSION=v1.20.0
ARG VELERO_VERSION=v1.7.2

COPY requirements.txt /tmp

SHELL ["/usr/bin/env", "bash", "-c"]

RUN \
  mkdir -p /opt/onecaas/bin && \
  apt-get update && apt-get upgrade -y && \
  apt-get install -y python3 python3-pip wget && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  wget -q https://github.com/vmware-tanzu/velero/releases/download/${VELERO_VERSION}/velero-${VELERO_VERSION}-linux-amd64.tar.gz \
    https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
  tar zxvf velero-${VELERO_VERSION}-linux-amd64.tar.gz  && \
  chmod +x velero-${VELERO_VERSION}-linux-amd64/velero  && \
  mv velero-${VELERO_VERSION}-linux-amd64/velero /opt/onecaas/bin  && \
  chmod +x kubectl  && \
  mv kubectl /opt/onecaas/bin  && \
  pip3 install -r tmp/requirements.txt
