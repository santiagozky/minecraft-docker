FROM    ubuntu:21.04
EXPOSE 19132/udp
RUN apt-get update
RUN apt-get install -y  curl wget unzip
WORKDIR  /opt/minecraft
ADD get.sh ./
RUN chmod +x ./get.sh
RUN ./get.sh
RUN chmod +x bedrock/bedrock_server
#LINK config to a new folder so we can mount that as a volume
RUN mkdir /opt/minecraft/config
RUN mv bedrock/server.properties config/
RUN mv bedrock/permissions.json config/
RUN mv bedrock/whitelist.json config/
RUN ln -s /opt/minecraft/config/server.properties /opt/minecraft/bedrock/server.properties && \
    ln -s /opt/minecraft/config/permissions.json /opt/minecraft/bedrock/permissions.json && \
    ln -s /opt/minecraft/config/whitelist.json /opt/minecraft/bedrock/whitelist.json
# Data and config volumes
VOLUME   /opt/minecraft/bedrock/worlds
VOLUME   /opt/minecraft/config
#Add volumes for other extensions later
WORKDIR /opt/minecraft/bedrock
ENV LD_LIBRARY_PATH=.
CMD     /opt/minecraft/bedrock/bedrock_server
