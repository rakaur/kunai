# syntax=docker/dockerfile:1
FROM ruby:3.1-alpine AS build
RUN apk update && \
    apk upgrade
WORKDIR /app
COPY Gemfile* .
RUN bundle config set --global without development test
RUN bundle install --jobs=4

FROM ruby:3.1-alpine
#RUN apk update && \
#    apk upgrade && \
#    apk add nothing_yet && \
#    rm -rf /var/cache/apk/*
WORKDIR /app
RUN bundle config set --global without development test
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY . .

EXPOSE 6667
ENTRYPOINT bin/kunai
