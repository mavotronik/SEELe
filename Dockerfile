FROM golang:1.22-alpine AS build

WORKDIR /src
RUN apk add --no-cache git

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 go build -ldflags="-s -w" -o /seele ./cmd/seele

FROM alpine:3.20

RUN apk add --no-cache ca-certificates

COPY --from=build /seele /usr/local/bin/seele

EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/seele"]
CMD ["-listen", ":8080", "-no-gpio"]
