[![Ruby](https://github.com/rakaur/kunai/actions/workflows/ruby.yml/badge.svg?branch=main)](https://github.com/rakaur/kunai/actions/workflows/ruby.yml)
[![Test Coverage](https://api.codeclimate.com/v1/badges/981b8f06d636fdcd2603/test_coverage)](https://codeclimate.com/github/rakaur/kunai/test_coverage)
[![Maintainability](https://api.codeclimate.com/v1/badges/981b8f06d636fdcd2603/maintainability)](https://codeclimate.com/github/rakaur/kunai/maintainability)
[![CodeQL](https://github.com/rakaur/kunai/actions/workflows/codeql-analysis.yml/badge.svg?branch=main)](https://github.com/rakaur/kunai/actions/workflows/codeql-analysis.yml)

---

# kunai

Kunai is an IRC server written in pure idiomatic Ruby with a hybrid TDD/BDD
development methodology. No, no one uses IRC. This is just for fun.

## Setup

Kunai was created with Ruby 3.1.2 as the current version. I haven't tested it
on older versions, but it should run on 3.x and (probaby?) 2.7+. Assuming
you have the appropriate Ruby available, the following sequence of commands
should get things going:

  * `$ git clone https://github.com/rakaur/kunai.git`
  * `$ cd kunai`
  * `$ bundle install`
  * `$ rake test`

### Docker

I mostly use docker for development, and the included `Dockerfile` will build an
image based on `ruby:3.1-alpine` with all required dependencies and gems already
installed. It is set to expose port 6667 only by default. Running this image
in a container will execute `bin/kunai` by default, but the entrypoint script
will launch any given command prefixed with `bundle exec`. There is also an
included `docker-compose.yml` that right now doesn't offer anything over the
`Dockerfile` but that may change as the project grows.

There are a couple of approaches. The simplest and easiest is probably to just
use the image on DockerHub:

  * `$ docker run --rm -it rakaur/kunai:latest`

You can also build an image from the git repository:

  * `$ git clone https://github.com/rakaur/kunai.git`
  * `$ cd kunai`
  * `$ docker build . -t kunai`
  * `$ docker run --rm -it kunai`

Images built from this `Dockerfile` run in production mode by default.

You can also use `docker-compose`:

  * `$ git clone https://github.com/rakaur/kunai.git`
  * `$ cd kunai`
  * `$ docker-compose up --build`

Containers started via `docker-compose` run in development mode by default.

## Tests

Kunai is developed in a sort of hybrid TDD/BDD manner. There are lots of tests.

  * `$ rake test`

The tests also run in the docker image:

  * `$ docker run --rm -it kunai_ircd rake test`

Where `kunai_ircd` is the name/tag/id of the built image. You can also use
`docker-compose`:

  * `$ docker-compose run --rm ircd rake test`

---

So long, and thanks for all the fish.
