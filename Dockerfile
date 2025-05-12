# Dockerfile
FROM node:18-alpine
RUN apk update && \
    apk add curl
WORKDIR /app
COPY . .
RUN npm install
CMD ["node", "server.js"]
EXPOSE 3005

