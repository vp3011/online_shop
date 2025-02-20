# Stage 1: Build using Node.js with Alpine
FROM node:18-alpine as builder

# Set working directory
WORKDIR /app

# Install dependencies first (leveraging Docker layer caching)
COPY package*.json ./

# Install production dependencies only
RUN npm install --only=production

# Copy the rest of the application files
COPY . .

# Build the project
RUN npm run build

# Stage 2: Use a lightweight Distroless Alpine base for the final image
FROM gcr.io/distroless/nodejs18-alpine

# Set working directory
WORKDIR /app

# Copy built files from the builder stage
COPY --from=builder /app /app

# Expose port 3000 for the app
EXPOSE 3000

# Run as a non-root user for better security
USER node

# Start the application
CMD ["node_modules/.bin/vite", "--host", "0.0.0.0", "--port", "3000"]
