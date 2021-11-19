FROM cirrusci/flutter as source
WORKDIR /src
COPY . .
RUN flutter pub get
RUN flutter build web

FROM nginx
COPY --from=source /src/build/web /usr/share/nginx/html