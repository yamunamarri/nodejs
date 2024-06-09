# Stage 1: Build stage
FROM node:16-alpine AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Build the application (if you have a build step)
# RUN npm run build

# Stage 2: Production stage
FROM node:16-alpine AS production

# Set the working directory
WORKDIR /app

# Copy only the necessary files from the build stage
COPY --from=build /app .

# Install only production dependencies
RUN npm install --production

# Expose the application port
EXPOSE 3000

# Command to run the application
CMD ["node", "index.js"]