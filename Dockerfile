FROM docker:19.03

ENV PATH "$PATH:/opt/google-cloud-sdk/bin"
RUN wget -q "https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz" -O google-cloud-sdk.tar.gz && \
    tar -xf google-cloud-sdk.tar.gz -C /opt && \
    apk add python && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    rm google-cloud-sdk.tar.gz

RUN wget -q https://get.helm.sh/helm-v3.1.2-linux-amd64.tar.gz -O helm.tar.gz && \
    tar xf helm.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm && \
    rm -r linux-amd64

RUN wget -q https://github.com/AckeeDevOps/vaultier/releases/download/v2.1.0/vaultier_2.1.0_Linux_x86_64.tar.gz -O vaultier.tar.gz && \
    tar -xvf vaultier.tar.gz vaultier && \
    mv vaultier /usr/local/bin/vaultier && \
    chmod +x /usr/local/bin/vaultier
