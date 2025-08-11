# Küçük ve hızlı: Alpine
FROM node:20-alpine

WORKDIR /app

# Bağımlılıklar
COPY package*.json ./
RUN npm ci --only=production

# Uygulama dosyaları
COPY . .

# Ortam
ENV NODE_ENV=production
ENV PORT=3000
EXPOSE 3000

# Healthcheck için curl ekle
RUN apk add --no-cache curl

# Konteyner içi healthcheck
HEALTHCHECK --interval=10s --timeout=3s --retries=10 \
  CMD curl -fsS http://localhost:${PORT}/health || exit 1

# Uygulama başlat
CMD ["node", "index.js"]