FROM alpine
RUN apk add --no-cache envsubst kustomize
WORKDIR /home/argocd/cmp-server/config/
COPY plugin.yaml ./