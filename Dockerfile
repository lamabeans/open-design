FROM node:22-bullseye-slim

WORKDIR /usr/src/app

# Enable pnpm
RUN corepack enable && corepack prepare pnpm@latest --activate

# Copy all repository files first (needed for scripts/postinstall.mjs)
COPY . .

# Install dependencies using pnpm
RUN pnpm install --frozen-lockfile

# Build the project
RUN pnpm run build || true

# Set production environment
ENV NODE_ENV=production
ENV PORT=3000
EXPOSE 3000

# Start the application
CMD ["pnpm", "start"]
