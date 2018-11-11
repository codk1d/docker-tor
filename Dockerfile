FROM buildpack-deps:stretch-curl as downloader

ARG TOR_VERSION=8.0.3

ARG GPG_KEYS=0x4E2C6E8793298290

RUN apt-get --quiet update && DEBIAN_FRONTEND=noninteractive apt-get --quiet --assume-yes install xz-utils

RUN (gpg --keyserver pool.sks-keyservers.net --recv-keys ${GPG_KEYS} || gpg --keyserver pgp.mit.edu --recv-keys ${GPG_KEYS})

RUN gpg --fingerprint 0x4E2C6E8793298290

ADD https://www.torproject.org/dist/torbrowser/${TOR_VERSION}/tor-browser-linux64-${TOR_VERSION}_en-US.tar.xz tor-browser-linux64-${TOR_VERSION}_en-US.tar.xz

ADD https://www.torproject.org/dist/torbrowser/${TOR_VERSION}/tor-browser-linux64-${TOR_VERSION}_en-US.tar.xz.asc tor-browser-linux64-${TOR_VERSION}_en-US.tar.xz.asc

RUN gpg --verify tor-browser-linux64-${TOR_VERSION}_en-US.tar.xz.asc tor-browser-linux64-${TOR_VERSION}_en-US.tar.xz

RUN tar --extract --xz --file tor-browser-linux64-${TOR_VERSION}_en-US.tar.xz

FROM debian:stretch-20180625 as tor

RUN apt-get --quiet update && DEBIAN_FRONTEND=noninteractive apt-get --quiet --assume-yes install libgtk-3-0 libdbus-glib-1-2 libxt6 libcanberra-gtk-module libcanberra-gtk3-module

COPY --from=downloader /tor-browser_en-US /usr/lib/tor-browser

RUN chmod --recursive +rx /usr/lib/tor-browser

RUN addgroup --system --gid 999 tors

RUN adduser --system --uid 9999 --gid 999 tor

RUN chown --recursive tor:tors /usr/lib/tor-browser

USER tor

ENTRYPOINT [ "/usr/lib/tor-browser/Browser/start-tor-browser" ]
