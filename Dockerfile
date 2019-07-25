FROM alpine:latest
MAINTAINER avpnusr
ARG PAR2TAG=v0.8.0
ARG GITTAG=2.3.9

COPY ./requirements.txt ./start.sh /

RUN buildDeps="gcc g++ git mercurial make automake autoconf python-dev openssl-dev libffi-dev musl-dev tzdata" \
  && apk --update --no-cache add $buildDeps \
  && cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime \
  && echo "Europe/Berlin" > /etc/timezone \
  && apk --no-cache add \
    python \
    py2-pip py2-openssl \
    ffmpeg-libs \
    ffmpeg \
    unrar \
    openssl \
    ca-certificates \
    p7zip \
    libgomp \
&& pip install --upgrade pip --no-cache-dir \
&& pip install -r /requirements.txt --upgrade --no-cache-dir \
&& git clone --depth 1 --branch ${PAR2TAG} https://github.com/Parchive/par2cmdline.git \
&& cd /par2cmdline \
&& sh automake.sh \
&& ./configure \
&& make \
&& make install \
&& cd / \
&& rm -rf par2cmdline \
&& git clone --depth 1 --branch ${GITTAG} https://github.com/sabnzbd/sabnzbd.git \
&& cd /sabnzbd \
&& python tools/make_mo.py \
&& cd / \
&& chmod +x /start.sh \
&& rm -rf /yenc \
&& apk del $buildDeps \
&& rm -rf \
    /var/cache/apk/* \
    /par2cmdline \
    /requirements.txt \
    /sabnzbd/.git \
    /tmp/*

EXPOSE 8080

HEALTHCHECK --interval=60s --timeout=15s --start-period=120s \
            CMD wget --no-check-certificate --quiet --spider 'http://localhost:8080' || exit 1

VOLUME ["/config", "/complete", "/incomplete"]

WORKDIR /sabnzbd

CMD ["/start.sh"]
