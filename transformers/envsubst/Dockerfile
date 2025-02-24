FROM scratch AS transformers
ARG KRM_VERSION=v0.10.0
ARG KUBECTL_VERSION=v1.31.5

# Dowload krm-kustomize-envsubst
ADD https://github.com/logandavies181/kustomize-krm-envsubst/releases/download/${KRM_VERSION}/kustomize-krm-envsubst_Darwin_arm64.tar.gz /transformers/envsubst/bin/linux/aarch64/
ADD https://github.com/logandavies181/kustomize-krm-envsubst/releases/download/${KRM_VERSION}/kustomize-krm-envsubst_Linux_arm64.tar.gz /transformers/envsubst/bin/linux/arm64/
ADD https://github.com/logandavies181/kustomize-krm-envsubst/releases/download/${KRM_VERSION}/kustomize-krm-envsubst_Linux_x86_64.tar.gz /transformers/envsubst/bin/linux/amd64/

# Dowload kubectl
ADD https://dl.k8s.io/${KUBECTL_VERSION}/bin/linux/amd64/kubectl /transformers/envsubst/bin/linux/amd64/
ADD https://dl.k8s.io/${KUBECTL_VERSION}/bin/linux/arm64/kubectl /transformers/envsubst/bin/linux/arm64/
ADD https://dl.k8s.io/${KUBECTL_VERSION}/bin/darwin/arm64/kubectl /transformers/envsubst/bin/linux/aarch64/

FROM alpine
ARG TARGETOS
ARG TARGETARCH
COPY --from=transformers /transformers/envsubst/bin/${TARGETOS}/${TARGETARCH} /usr/local/bin/
RUN tar -xvf /usr/local/bin/kustomize-krm-envsubst_*.tar.gz -C /usr/local/bin \
  && rm /usr/local/bin/kustomize-krm-envsubst_*.tar.gz \
  && chmod +x /usr/local/bin/kubectl
RUN apk add --no-cache kustomize helm bash curl tar gzip

RUN case `uname -m` in \
    x86_64) ARCH=amd64; ;; \
    armv7l) ARCH=arm; ;; \
    aarch64) ARCH=arm64; ;; \
    ppc64le) ARCH=ppc64le; ;; \
    s390x) ARCH=s390x; ;; \
    *) echo "un-supported arch, exit ..."; exit 1; ;; \
    esac && \
    echo "export ARCH=$ARCH" > /envfile && \
    cat /envfile

RUN . /envfile && echo $ARCH && \
    curl -sL "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_${ARCH}.tar.gz" | tar xz -C /tmp && \
    mv /tmp/eksctl /usr/bin && \
    chmod +x /usr/bin/eksctl

RUN apk add --update --no-cache py3-pip && \
    pip3 install --break-system-packages --upgrade pip setuptools && \
    pip3 install --break-system-packages awscli && \
    pip3 cache purge

COPY plugin.yaml /home/argocd/cmp-server/config/plugin.yaml