# -----
FROM node:14.4-alpine AS build

RUN apk update
RUN apk add --no-cache python gcc make g++ build-base git lzo bzip2 openssl bash file postgresql mosquitto nano go coreutils
#ENV PYTHONUNBUFFERED=1
#RUN apk add --no-cache python3 && \
#    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi 


#RUN mv /usr/src/dagviz/k-explorer /usr/src/k-explorer
#RUN cd /usr/src/k-explorer && npm install && npm link
#RUN npm link k-explorer
#RUN mv /usr/src/dagviz/k-explorer /usr/src/dagviz/k-explorer
#RUN cd /usr/src/dagviz/k-explorer && npm install && npm link
#RUN npm link k-explorer

RUN addgroup -S gor-desktop && adduser -S gor-desktop -G gor-desktop
RUN mkdir -p /run/postgresql
RUN chown gor-desktop:gor-desktop /run/postgresql

# Tell docker that all future commands should run as the appuser user

WORKDIR /home/gor-desktop/releases/gor-desktop
COPY . .
RUN rm -rf node_modules
RUN rm package-lock.json
#RUN chown -R gor-desktop:gor-desktop .


RUN npm install
RUN npm install @aspectron/process-list
RUN npm install -g emanator@latest
RUN emanate --local-binaries --no-ssh


USER gor-desktop

EXPOSE 16210 16211 16310 16311 11224 18792 
# 18787 
# (pgsql - may conflict with other instances)

ENTRYPOINT ["node","gor-desktop.js","--init","--nice","--mine"]
