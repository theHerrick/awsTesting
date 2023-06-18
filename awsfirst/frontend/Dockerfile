FROM node:18.16-alpine3.17
WORKDIR /app
COPY package*.json /app
ENV NODE_ENV=production
RUN npm ci --only=production && npm cache clean --force
COPY . /app
CMD npm start
