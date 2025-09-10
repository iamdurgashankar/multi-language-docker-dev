# Multi-stage build for production
FROM node:18-alpine as base

WORKDIR /app

# Copy package files
COPY package*.json ./

# Development stage
FROM base as development
ENV NODE_ENV=development
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "run", "dev"]

# Production stage  
FROM base as production
ENV NODE_ENV=production
RUN npm ci --only=production && npm cache clean --force
COPY . .
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001
USER nextjs
EXPOSE 3000
CMD ["npm", "start"]