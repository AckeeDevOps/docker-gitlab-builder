FROM docker:20.10.21

LABEL tag="ackee-gitlab" \
      author="Ackee 🦄" \
      description="Tailor-made image for our stack"

ENV GITLAB_CI_UTILS_VERSION "2.13.0"
ENV PATH "$PATH:/opt/google-cloud-sdk/bin"

RUN apk add --no-cache bash coreutils curl jq git python3 rsync zip py3-pip gettext
RUN pip3 install yq

RUN wget -q "https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz" -O google-cloud-sdk.tar.gz && \
    tar -xf google-cloud-sdk.tar.gz -C /opt && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud components install kubectl && \
    gcloud components install gsutil && \
    gcloud components install beta && \
    gcloud components install alpha && \
    gcloud components install gke-gcloud-auth-plugin && \
    gcloud components update && \
    rm -rf $(find /opt/google-cloud-sdk/ -regex ".*/__pycache__") && \
    rm -rf /opt/google-cloud-sdk/.install/.backup && \
    google-cloud-sdk.tar.gz

RUN wget -q https://get.helm.sh/helm-v3.5.3-linux-amd64.tar.gz -O helm.tar.gz && \
    tar xf helm.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm && \
    rm -r linux-amd64

RUN wget -q https://releases.hashicorp.com/vault/1.11.2/vault_1.11.2_linux_amd64.zip -O vault.zip && \
    unzip vault.zip && \
    mv vault /usr/local/bin/vault && \
    chmod +x /usr/local/bin/vault && \
    rm vault.zip

RUN wget -q https://github.com/argoproj/argo-rollouts/releases/download/v1.2.2/kubectl-argo-rollouts-linux-amd64 -O kubectl-argo-rollouts && \
    mv kubectl-argo-rollouts /usr/local/bin && \
    chmod +x /usr/local/bin/kubectl-argo-rollouts

COPY --from=docker/compose:alpine-1.27.4 /usr/local/bin/docker-compose /usr/local/bin/

ADD https://raw.githubusercontent.com/AckeeDevOps/gitlab-ci-utils/$GITLAB_CI_UTILS_VERSION/scripts/helper_functions.sh /usr/local/bin/helper_functions.sh

RUN chmod +x /usr/local/bin/helper_functions.sh
