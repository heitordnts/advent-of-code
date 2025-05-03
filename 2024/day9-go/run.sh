#docker build -t temp-go-app . && \
#docker run --rm temp-go-app && \
#docker rmi temp-go-app

docker run --rm -it \
  -v $(pwd):/app \
  -w /app \
  golang:1.20 \
  go run main.go $1
