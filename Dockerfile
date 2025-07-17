FROM golang:latest AS builder
WORKDIR /app
COPY  go.mod ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o /app/test-build ./cmd/app/  

FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/ . 
EXPOSE 8080
CMD ["./test-build"]
