# STAGE 1 - BUILD
FROM openjdk:16-slim-buster as build

RUN apt-get update 
RUN useradd -M -s /bin/false --uid 1000 minecraft

# MC VERSION: 1.16.3
ENV MINECRAFT_VERSION_SHA=f02f4473dbf152c23d7d484952121db0b36698cb

RUN mkdir minecraft & chown minecraft:minecraft /minecraft

ADD https://launcher.mojang.com/v1/objects/${MINECRAFT_VERSION_SHA}/server.jar ./minecraft/server.jar

RUN chmod +x ./minecraft/server.jar

# STAGE 2 - RUNTIME
FROM openjdk:16-slim-buster as runtime

ENV JAVA_MEM_SIZE=1g 

WORKDIR /minecraft

COPY --from=build ./minecraft/server.jar ./server.jar

COPY eula.txt eula.txt
COPY server.properties server.properties

VOLUME ["/minecraft/world"]

EXPOSE 25565

CMD java -Xmx${JAVA_MEM_SIZE} -Xms${JAVA_MEM_SIZE} -jar server.jar nogui