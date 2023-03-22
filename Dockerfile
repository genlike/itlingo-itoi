ARG NODE_VERSION=14.21.0
# FROM node:${NODE_VERSION}-alpine
# RUN apk add --no-cache make pkgconfig gcc g++ python libx11-dev libxkbfile-dev libsecret-dev
# ARG version=latest
# WORKDIR /home/theia



FROM node:${NODE_VERSION}-alpine
# See : https://github.com/theia-ide/theia-apps/issues/34

RUN apk add --no-cache git openssh bash libsecret
ENV HOME /home/theia
WORKDIR /home/theia
# COPY --from=0 --chown=theia:theia /home/theia /home/theia

# RUN sudo apt-get install -y g++ gcc make python2.7 pkg-config libx11-dev libxkbfile-dev libsecret-1-dev
RUN apk add --no-cache make pkgconfig gcc g++ python3 libx11-dev libxkbfile-dev libsecret-dev nano
RUN apk add openjdk11-jre
# ADD $version.package.json ./package.json
# ARG GITHUB_TOKEN
COPY ide /home/theia/ide
#COPY startup.sh .
#RUN chmod +x startup.sh

#Setup language servers folder
RUN mkdir /home/theia/ls
RUN npm install -g @vscode/vsce

#Compile ASL extension
WORKDIR /home/theia
COPY plugins/asl-langium /home/theia/asl-langium
RUN echo ls -l
RUN chmod +x /home/theia/asl-langium/server/asl/bin/generator.sh
RUN chmod +x /home/theia/asl-langium/server/asl/bin/importer.sh
WORKDIR /home/theia/asl-langium
RUN yarn
RUN vsce package
RUN cp asl-langium-0.0.1.vsix /home/theia/ide/plugins
RUN cd .. && rm -rf asl-langium


#Compile RSL extension
WORKDIR /home/theia
COPY plugins/rsl-vscode-extension /home/theia/rsl-vscode-extension
WORKDIR /home/theia/rsl-vscode-extension
RUN yarn
RUN vsce package
RUN cp rsl-vscode-extension-0.0.1.vsix /home/theia/ide/plugins
RUN cd .. && rm -rf rsl-vscode-extension

WORKDIR /home/theia/ide

ENV NODE_OPTIONS "--max-old-space-size=8192"
RUN yarn --cache-folder ./ycache && rm -rf ./ycache
RUN yarn theia build
WORKDIR /home/theia/ide/itlingo-itoi
RUN yarn
WORKDIR /home/theia/ide/browser-app
RUN yarn



# EXPOSE $PORT
EXPOSE 3000

# RUN addgroup theia && \
#    adduser -G theia -s /bin/sh -D theia;
# RUN chmod g+rw /home && \
#    mkdir -p /home/project && \
#    chown -R theia:theia /home/theia && \
#    chown -R theia:theia /home/project;

# ENV SHELL=/bin/bash \
#    THEIA_DEFAULT_PLUGINS=local-dir:/home/theia/pub/plugins
# ENV USE_LOCAL_GIT true

# USER theia

