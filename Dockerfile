FROM docker:19.03

RUN wget -q https://github.com/AckeeDevOps/vaultier/releases/download/v2.1.0/vaultier_2.1.0_Linux_x86_64.tar.gz -O vaultier.tar.gz && \
  tar -xvf vaultier.tar.gz vaultier && \
  mv vaultier /usr/local/bin/vaultier && \
  chmod +x /usr/local/bin/vaultier
