FROM node:22-bullseye-slim

WORKDIR /usr/src/app

# Enable pnpm
RUN corepack enable && corepack prepare pnpm@latest --activate

# Copy package configuration
COPY package*.json pnpm-lock.yaml* ./

# Install dependencies
RUN pnpm install --frozen-lockfile || npm install

# Copy all source files
COPY . .

# Build the project
RUN npm run build || true

# Set production environment
ENV NODE_ENV=production
ENV PORT=3000
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
