# Step 1: Build the React application
FROM node:14 AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Step 2: Serve the application with Nginx
FROM nginx:alpine

# Copy the build output to Nginx's html directory
COPY --from=build /app/build /usr/share/nginx/html

# Copy Nginx configuration file (if you have a custom configuration)
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
