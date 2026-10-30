# Build stage
FROM golang:1.26-alpine AS builder

WORKDIR /src

COPY go.mod ./
RUN go mod download

COPY cmd ./cmd
COPY internal ./internal

RUN CGO_ENABLED=0 GOOS=linux \
    go build -trimpath \
    -ldflags="-s -w" \
    -o /out/gosass ./cmd/server

# Minimal non-root runtime
FROM gcr.io/distroless/static-debian12:nonroot

WORKDIR /
COPY --from=builder /out/gosass /gosass

ENV PORT=8080
EXPOSE 8080

USER 65532:65532
ENTRYPOINT ["/gosass"]
