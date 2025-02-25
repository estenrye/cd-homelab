FROM golang:1.19-alpine as builder
RUN apk add git
ENV CGO_ENABLED=0
ENV GOOS=linux
ARG TARGETARCH

# Shallow copy kubernetes-json-schema
ARG KUBECTL_VERSION=v1.31.5
WORKDIR /go/src/kubernetes-json-schema
RUN git init
RUN git remote add -f origin https://github.com/yannh/kubernetes-json-schema.git
RUN git config core.sparseCheckout true
RUN echo <<EOF > .git/info/sparse-checkout
${KUBECTL_VERSION}/
${KUBECTL_VERSION}-local/
${KUBECTL_VERSION}-standalone/
${KUBECTL_VERSION}-standalone-strict/
schemas/
EOF
RUN git pull origin master

# Pull datreeio/CRDs-catalog
WORKDIR /go/src/CRDs-catalog
RUN git clone --depth=1 https://github.com/datreeio/CRDs-catalog.git

# Compile kustomize-krm-envsubst
WORKDIR /go/src/
RUN git clone --depth=1 -b add_env_override https://github.com/estenrye/kustomize-krm-envsubst.git
WORKDIR /go/src/kustomize-krm-envsubst
RUN go mod download
RUN GOOS=linux GOARCH=$TARGETARCH go build -ldflags '-w -s' -v -o /usr/local/bin/kustomize-krm-envsubst ./

FROM scratch AS transformers
ARG KRM_VERSION=v0.10.0
ARG KUBECTL_VERSION=v1.31.5

# Dowload kubectl
ADD https://dl.k8s.io/${KUBECTL_VERSION}/bin/linux/amd64/kubectl /transformers/envsubst/bin/linux/amd64/
ADD https://dl.k8s.io/${KUBECTL_VERSION}/bin/linux/arm64/kubectl /transformers/envsubst/bin/linux/arm64/
ADD https://dl.k8s.io/${KUBECTL_VERSION}/bin/darwin/arm64/kubectl /transformers/envsubst/bin/linux/aarch64/

FROM alpine
ARG TARGETOS
ARG TARGETARCH
ARG KUBECTL_VERSION=v1.31.5

ENV \
  KUBECONFORM_NATIVE_SCHEMA_REGISTRY_URL="/usr/local/schema/kubernetes-json-schema/{{.NormalizedKubernetesVersion}}-standalone{{.StrictSuffix}}/{{.ResourceKind}}{{.KindSuffix}}.json" \
  KUBECONFORM_CRD_REGISTRY_URL="/usr/local/schema/CRDs-catalog/{{.Group}}/{{.ResourceKind}}_{{.ResourceAPIVersion}}.json" \
  KUBECONFORM_K8S_VERSION="${KUBECTL_VERSION}"
COPY --from=builder /usr/local/bin/kustomize-krm-envsubst /usr/local/bin/
COPY --from=builder /go/src/kubernetes-json-schema /usr/local/schema/
COPY --from=builder /go/src/CRDs-catalog /usr/local/schema/
COPY --from=transformers /transformers/envsubst/bin/${TARGETOS}/${TARGETARCH} /usr/local/bin/
# RUN tar -xvf /usr/local/bin/kustomize-krm-envsubst_*.tar.gz -C /usr/local/bin \
#   && rm /usr/local/bin/kustomize-krm-envsubst_*.tar.gz
RUN chmod +x /usr/local/bin/kubectl
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

ENTRYPOINT [ "/usr/local/bin/kustomize-krm-envsubst" ]