FROM alpine:latest as builder

ARG KASPA_VERSION

WORKDIR /app

RUN apk --no-cache update &&\
    apk --no-cache add curl zip

RUN curl -LJO https://github.com/kaspanet/kaspad/releases/download/${KASPA_VERSION}/kaspad-${KASPA_VERSION}-linux.zip &&\
    unzip kaspad-${KASPA_VERSION}-linux.zip &&\
    rm kaspad-${KASPA_VERSION}-linux.zip

WORKDIR /app/bin

FROM alpine:latest
COPY --from=builder /app/bin/kaspad /usr/local/bin/kaspad
COPY --from=builder /app/bin/kaspawallet /usr/local/bin/kaspawallet
RUN apk --no-cache update

EXPOSE 16111 16110

CMD [ "/usr/local/bin/kaspad" ]