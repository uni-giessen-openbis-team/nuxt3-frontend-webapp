FROM node:18 AS base

RUN npm i -g pnpm 

WORKDIR /app

# Files required by pnpm install
COPY package.json pnpm-lock.yaml ./

# Install dependencies
RUN pnpm install 

# Bundle app source
COPY . .

EXPOSE 3000

RUN pnpm dev 

CMD [ "tail", "-f", "/dev/null" ]