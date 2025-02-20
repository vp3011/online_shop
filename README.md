# Online Shop 🛍️ for Hackathon Phase 1 - Submission

Welcome to the Online Shop project! This is a modern e-commerce platform built using Vite, Node.js, and Docker.

# Features
- 🛒 *E-commerce Platform* – A fully functional online-shop app 
- ⚡ *Built with Vite* – For Fast development
- 🐳 *Dockerized with a Lightweight Image*– Uses Distrolessor image which provides security & performance  
- 📡 *Exposed on Port 3000* – For deploy on any server

1️⃣ Prerequisites
Ensure you have the following installed:

Docker (for containerized setup)
Node.js v16+ (if running locally)
Git (for cloning the repository)

2️⃣ Clone the Repository
git clone https://github.com/vp3011/online_shop.git
ls
cd online_shop

---
🛠 Creating the Dockerfile for our project
Before building the Docker image, create a Dockerfile in the root of the project with the following content:

# Stage 1: Build using Node.js with Alpine
FROM node:18-alpine as builder

# Set working directory
WORKDIR /app

# Copy package.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Build the project
RUN npm run build

# Stage 2: Use a lightweight Distroless image for the final image
FROM gcr.io/distroless/nodejs18

# Set working directory
WORKDIR /app

# Copy only necessary files from builder stage
COPY --from=builder /app /app

# Expose port 3000 for the app
EXPOSE 3000

# Start the application
CMD ["node_modules/.bin/vite", "--host", "0.0.0.0", "--port", "3000"]
---
🛠 Creating the .dockerignore file to prevents unnecessary files from being copied into the image for our project
node_modules
.git
.env
---

🐳 build an image & Running with Docker
3️⃣ Build and Run the Container
- Step 1: Build the Docker Image
docker build -t online-shop:latest .
- Step 2: List All Docker Images
docker images 
- Step 3: Run the Container
docker run -d -p 3000:3000 -- name online-shop-app online_shop:latest
- Step 4: Check Running Containers
docker ps
4️⃣ Verify if the Container is Running
docker ps
