FROM node:20-alpine

WORKDIR /app

# Sadece bağımlılık dosyalarını kopyala
COPY package*.json ./

# Prod kurulum (lock yoksa install'a düşer)
ENV NODE_ENV=production PORT=3000 HOST=0.0.0.0
RUN npm ci --omit=dev || npm install --omit=dev

# Uygulama kodu
COPY . .

# Uygulamanın dinleyeceği port
EXPOSE 3000

# Uygulamayı başlat
CMD ["node", "index.js"]