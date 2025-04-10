FROM node:latest
WORKDIR /app
ADD . .
EXPOSE 3000
CMD ["node", "index.js"]
