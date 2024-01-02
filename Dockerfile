FROM alpine AS builder

RUN apk update
RUN apk upgrade
RUN apk add --update alpine-sdk linux-headers git zlib-dev openssl-dev gperf cmake
WORKDIR /telegram-bot-api
RUN git clone --recursive https://github.com/tdlib/telegram-bot-api.git .
WORKDIR /telegram-bot-api/build
RUN cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=.. ..
RUN cmake --build . --target install

FROM alpine
RUN apk update
RUN apk add --update libstdc++ zlib openssl
WORKDIR /telegram-bot-api
COPY --from=builder telegram-bot-api/bin/telegram-bot-api .
ENTRYPOINT ["./telegram-bot-api"]
