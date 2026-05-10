# ====== Build Backend ======
FROM golang:1.25-alpine AS backend-builder

WORKDIR /app/backend

COPY backend/go.mod ./
RUN go mod download

COPY backend .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app


# ====== Final Image ======
FROM alpine:latest

WORKDIR /app

COPY --from=backend-builder /app/backend/app .
EXPOSE 8080
CMD ["./app"]