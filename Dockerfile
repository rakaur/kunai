# syntax=docker/dockerfile:1
FROM ruby:3.1-alpine AS build
RUN apk update && \
    apk upgrade
WORKDIR /kunai
COPY Gemfile* .
RUN bundle config set --global without development
RUN bundle install --jobs=4

FROM ruby:3.1-alpine
RUN apk update && \
    apk upgrade && \
#    apk add nothing_yet && \
    rm -rf /var/cache/apk/*
WORKDIR /kunai
RUN bundle config set --global without development
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY . .

EXPOSE 6667
CMD ["bin/kunai", "--environment", "production"]
ENTRYPOINT ["./docker-entrypoint.sh"]
