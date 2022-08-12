FROM node:16-alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . . 
RUN npm run build

## /app/build <-- we need this folder for production


FROM nginx
## in development mode doesnt matter but elastik beanstalk use this
EXPOSE 80
## we copy the build forlder to the nginx folder which is specific for serving static html files.
COPY --from=builder /app/build usr/share/nginx/html

## the default command for nginx image is to start nginx server so we dont need to specifically describe it