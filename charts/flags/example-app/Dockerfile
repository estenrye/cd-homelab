FROM --platform=$BUILDPLATFORM golang:1.23-alpine AS build-env
COPY go.mod go.sum main.go /app/

WORKDIR /app
ARG TARGETOS
ARG TARGETARCH
RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} GODEBUG=netdns=go \
    go build -a -ldflags='-s -w -extldflags "-static"' -o /tmp/example ./main.go

# Final container has basically nothing in it but the executable
FROM scratch
COPY --from=build-env /tmp/example /example

EXPOSE 8080

ENTRYPOINT ["/example"]
CMD []
