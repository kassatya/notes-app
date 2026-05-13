# Stage 1: Build
FROM node:20-alpine AS builder

WORKDIR /app

COPY package.json ./
RUN npm install --production

COPY . .

# Stage 2: Production
FROM node:20-alpine

WORKDIR /app

COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app .

ENV PORT=8080
ENV DB_HOST=34.172.113.167
ENV DB_USER=admin
ENV DB_PASSWORD=mypassword
ENV DB_NAME=notes_123230189

EXPOSE 8080

CMD ["node", "server.js"]
