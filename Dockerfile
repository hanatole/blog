FROM ubuntu:24.04 AS builder
WORKDIR /app
RUN apt-get update -y && apt-get install -y hugo \
    && rm -rf /var/lib/apt/lists/*
COPY . .
RUN hugo build

FROM nginx:1.29.4-alpine3.23
COPY --from=builder /app/public/ /usr/share/nginx/html/
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"] 