FROM alpine:latest

RUN apk add --update \
    python \
    py-pip \
    git \
  && pip install --upgrade youtube_dl \
  && pip install tmdbsimple \
  && rm -rf /var/cache/apk/* \

RUN mkdir /opt/
RUN mkdir /opt/TheaterTrailers
WORKDIR /opt/
RUN git clone https://github.com/Electronickss/TheaterTrailers
RUN mkdir /opt/TheaterTrailers/Logs
RUN mkdir /opt/TheaterTrailers/Configs
RUN mkdir /opt/TheaterTrailers/Trailers
RUN mkdir /opt/TheaterTrailers/Cache

VOLUME ["/opt/TheaterTrailers/Trailers/"]
VOLUME ["/opt/TheaterTrailers/Logs/"
VOLUME ["/opt/TheaterTrailers/Configs/"]
VOLUME ["/opt/TheaterTrailers/Cache/"]

echo "00 */6 * * * /opt/TheaterTrailers/theaterTrailers.py 2 >> /opt/TheaterTrailers/Logs/theaterTrailers.cron.log" >> mycron && crontab mycron && rm mycron
