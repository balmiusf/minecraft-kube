# STAGE 1 - BUILD
FROM openjdk:16-slim-buster as build

RUN apt-get update 
RUN useradd -M -s /bin/false --uid 1000 minecraft

# MC VERSION: 1.16.3
ENV MINECRAFT_VERSION_SHA=f02f4473dbf152c23d7d484952121db0b36698cb

RUN mkdir ./opt/minecraft & chown minecraft:minecraft ./opt/minecraft/

ADD https://launcher.mojang.com/v1/objects/${MINECRAFT_VERSION_SHA}/server.jar ./opt/minecraft/server.jar

RUN chmod +x ./opt/minecraft/server.jar

# STAGE 2 - RUNTIME
FROM openjdk:16-slim-buster as runtime

ENV JAVA_MEM_SIZE=1g \ 
    EULA=false 

WORKDIR /opt/minecraft

COPY --from=build ./opt/minecraft/server.jar ./server.jar

COPY entrypoint.sh /home/entrypoint.sh

# copy the initial server.properties file
# COPY server.properties server.properties

VOLUME ["/opt/minecraft/"]

EXPOSE 25565

RUN chmod +x /home/entrypoint.sh
ENTRYPOINT ["sh", "/home/entrypoint.sh"]
CMD java -Xmx${JAVA_MEM_SIZE} -Xms${JAVA_MEM_SIZE} -jar server.jar nogui