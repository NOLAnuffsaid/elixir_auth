FROM elixir:1.10-alpine

RUN adduser -D -g "" wjmill

USER wjmill

COPY . /home/wjmill/app

WORKDIR /home/wjmill/app

ENTRYPOINT sh ./start.sh
