FROM golang:1.18

WORKDIR ./app

COPY . .

RUN go build -o msu-scholarship

CMD ["./msu-scholarship"]
