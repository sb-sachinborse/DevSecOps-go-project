# GoSaaS DevSecOps

A small SaaS-style dashboard served by a Go HTTP server. The frontend is embedded into the Go binary, so the runtime container does not need a separate static-assets directory.

## Requirements

- Go 1.26+
- Docker Engine
- Docker Compose plugin

## Run locally

```bash
go test ./...
go test -race ./...
go vet ./...
go run ./cmd/server
```

Open http://localhost:8000.

## HTTP endpoints

| Endpoint | Purpose |
|---|---|
| `/` | Static SaaS dashboard |
| `/healthz` | Liveness check |
| `/readyz` | Readiness check |
| `/api/v1/status` | Sample JSON API |

## Run with Docker

```bash
docker build -t gosass:local .
docker run --rm -p 8000:8000 --name gosass-app gosass:local
```

Or use Compose:

```bash
docker compose up --build -d
docker compose logs -f
docker compose down
```

## Project layout

```text
.
├── cmd/server/
│   ├── main.go
│   ├── main_test.go
│   └── web/index.html
├── Dockerfile
├── docker-compose.yaml
└── go.mod
```

## Before publishing

Replace `YOUR_USERNAME` in `go.mod` with your GitHub username, then run:

```bash
go mod tidy
```
