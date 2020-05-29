FROM docker:19.03

RUN apk add --no-cache bash curl jq

ENV PATH "$PATH:/opt/google-cloud-sdk/bin"
RUN wget -q "https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz" -O google-cloud-sdk.tar.gz && \
    tar -xf google-cloud-sdk.tar.gz -C /opt && \
    apk add python && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud components install kubectl && \
    gcloud components install gsutil && \
    rm google-cloud-sdk.tar.gz

RUN wget -q https://get.helm.sh/helm-v3.1.2-linux-amd64.tar.gz -O helm.tar.gz && \
    tar xf helm.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm && \
    rm -r linux-amd64

RUN wget -q https://releases.hashicorp.com/vault/1.4.0/vault_1.4.0_linux_amd64.zip -O vault.zip && \
    unzip vault.zip && \
    mv vault /usr/local/bin/vault && \
    chmod +x /usr/local/bin/vault && \
    rm vault.zip

RUN wget -q https://github.com/AckeeDevOps/vaultier/releases/download/v2.1.0/vaultier_2.1.0_Linux_x86_64.tar.gz -O vaultier.tar.gz && \
    tar -xvf vaultier.tar.gz vaultier && \
    mv vaultier /usr/local/bin/vaultier && \
    chmod +x /usr/local/bin/vaultier && \
    rm vaultier.tar.gz

COPY --from=docker/compose:alpine-1.25.5 /usr/local/bin/docker-compose /usr/local/bin/
