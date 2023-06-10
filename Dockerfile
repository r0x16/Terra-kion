FROM golang:1.18.10-bullseye

WORKDIR /tak

COPY go.mod go.sum ./
RUN go mod download

COPY . .

CMD ["go", "run", "main.go"]