# Step 1: Use an official Node.js runtime as a parent image
FROM node:18-alpine AS build

# Step 2: Set the working directory in the container
WORKDIR /app

# Step 3: Copy package.json and package-lock.json
COPY package*.json ./

# Step 4: Install app dependencies
RUN npm install

# Step 5: Copy the rest of the application code
COPY . .

# Step 6: Build the TypeScript code
RUN npm run build

# Step 7: Use a lightweight Node.js image for the production environment
FROM node:18-alpine AS production

# Step 8: Set the working directory in the container
WORKDIR /app

# Step 9: Copy only the built files and node_modules from the build stage
COPY --from=build /app/dist ./dist
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/package*.json ./

# Step 10: Create a non-root user and group
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Step 11: Change ownership of the app directory to the non-root user
RUN chown -R appuser:appgroup /app

# Step 12: Switch to the non-root user
USER appuser

# Step 13: Expose the port your app runs on
EXPOSE 3000

# Step 14: Define the command to run the app
CMD ["node", "dist/app.js"]
