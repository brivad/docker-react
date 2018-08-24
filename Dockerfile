# multi step dockerfile

# start of build phase
FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install

# in questa fase di build non ci interessa il sistema di volumi,
# non stiamo sviluppando...
COPY . .
RUN npm run build

# /app/build <--- all the stuff we care about

# end of build phase

# start of run phase
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

# l'immagine nginx imposta e esegue il suo start command
# quindi non serve definire un CMD
