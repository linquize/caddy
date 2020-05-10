FROM golang:1.14-alpine as builder

RUN apk add --no-cache ca-certificates

WORKDIR /src
ADD . .
RUN cd cmd/caddy && CGO_ENABLED=0 go build -o /caddy


FROM scratch

COPY --from=builder /etc/ssl/certs /etc/ssl/certs
COPY --from=builder /caddy /caddy

ENTRYPOINT ["/caddy"]
CMD ["run", "--config", "/etc/Caddyfile"]
