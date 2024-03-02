FROM golang:1.21-alpine AS builder

WORKDIR /app

COPY go.mod ./
RUN go mod download
COPY . .

RUN go build -v -o /gorunner .

FROM alpine:latest

WORKDIR /app
COPY --from=builder /gorunner .

COPY home.html ./

EXPOSE 8080
CMD ["./gorunner", "sh"]
