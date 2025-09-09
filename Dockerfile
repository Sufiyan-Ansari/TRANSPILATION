# Stage 1: Build
FROM node:22-slim AS builder

WORKDIR /app
COPY package*.json tsconfig.json ./
RUN npm install

COPY src ./src
RUN npm run build

# Stage 2: Run
FROM node:22-slim

WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY package*.json ./
RUN npm install --only=production

EXPOSE 3000
CMD ["node", "dist/app.js"]
