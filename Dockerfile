FROM alpine as build

ARG TARGETPLATFORM
ARG VERSION

WORKDIR /tmp

# Download the Massa package
COPY download-massa.sh .
RUN chmod u+x download-massa.sh
RUN ./download-massa.sh

FROM ubuntu:22.04

LABEL maintainer="f.sidhoum@hotmail.fr"
LABEL version=$VERSION
LABEL description="Massa node"

RUN mkdir /app
WORKDIR /app

COPY --from=build /tmp/massa/massa-node .

EXPOSE 31244
EXPOSE 31245
EXPOSE 33035

ENTRYPOINT ["/app/massa-node", "-p", "password"]
