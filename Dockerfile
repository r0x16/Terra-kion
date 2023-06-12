FROM golang:1.18.10-bullseye

WORKDIR /tak

RUN apt update && apt install -y \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

COPY go.mod go.sum ./
RUN go mod download

COPY . .

CMD ["go", "run", "main.go"]