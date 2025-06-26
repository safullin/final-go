FROM golang:1.23-alpine AS builder
ENV CGO_ENABLED=0
WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -ldflags="-s -w" -o app .

FROM scratch
WORKDIR /app
COPY --from=builder /src/app .
VOLUME ["/app"]
ENTRYPOINT ["./app"]
