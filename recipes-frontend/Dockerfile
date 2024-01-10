# Use Node.js base image
FROM node:latest

# Set the working directory in the container
WORKDIR /recipes-frontend

# Copy package.json and package-lock.json (if available)
COPY package*.json /recipes-frontend/

# Install dependencies
RUN npm install

# Copy the rest of your app's source code
COPY . /recipes-frontend

# Expose the port the app runs on
EXPOSE 3001

# Start the app
CMD ["npm", "start"]
