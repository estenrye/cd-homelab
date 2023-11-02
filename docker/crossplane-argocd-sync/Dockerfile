FROM --platform=$BUILDPLATFORM golang:1.21-alpine AS build-env
COPY app /app

WORKDIR /app
ARG TARGETOS
ARG TARGETARCH
RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} GODEBUG=netdns=go \
    go build -a -ldflags='-s -w -extldflags "-static"' -o /tmp/crossplane-argocd-cluster ./main.go

# Final container has basically nothing in it but the executable
FROM scratch
COPY --from=build-env /tmp/crossplane-argocd-cluster /crossplane-argocd-cluster

ENTRYPOINT ["/crossplane-argocd-sync"]
