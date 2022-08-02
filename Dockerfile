FROM alpine:latest as builder

ARG KASPA_VERSION

WORKDIR /app

RUN apk --no-cache update &&\
    apk --no-cache add curl zip

RUN curl -LJO https://github.com/kaspanet/kaspad/releases/download/${KASPA_VERSION}/kaspad-v0.12.4-linux.zip &&\
    unzip kaspad-v0.12.4-linux.zip &&\
    rm kaspad-v0.12.4-linux.zip

WORKDIR /app/bin

FROM alpine:latest
COPY --from=builder /app/bin/kaspad /usr/local/bin/kaspad
RUN apk --no-cache update

EXPOSE 16111 16110

CMD [ "/usr/local/bin/kaspad" ]