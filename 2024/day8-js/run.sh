#docker build -t temp-go-app . && \
#docker run --rm temp-go-app && \
#docker rmi temp-go-app

docker run --rm -it \
  -v $(pwd):/app \
  -w /app \
  node:20-alpine \
  node main2.js $1
