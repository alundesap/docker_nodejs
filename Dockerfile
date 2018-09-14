FROM alunde/opensuse:42.3
MAINTAINER andrew.lunde@sap.com

ENV GOPATH /go
ENV NAME chisel
ENV PACKAGE github.com/jpillora/$NAME
ENV PACKAGE_DIR $GOPATH/src/$PACKAGE

#Install more stuff if needed
# zypper ar http://download.opensuse.org/repositories/home:/darix:/apps/openSUSE_Leap_42.3/ darix
RUN zypper -n ar http://download.opensuse.org/repositories/home:/darix:/apps/openSUSE_Leap_42.3/ darix
RUN zypper -n --gpg-auto-import-keys install --no-recommends --auto-agree-with-licenses --force-resolution go git-core lsof netcat hostname mariadb-client nodejs8 npm8 \
	&& mkdir -p $PACKAGE_DIR \
	&& git clone https://$PACKAGE.git $PACKAGE_DIR \
	&& cd $PACKAGE_DIR \
	&& go build -ldflags "-X github.com/jpillora/chisel/share.BuildVersion=$(git describe --abbrev=0 --tags)" -o /usr/bin/$NAME \
	&& /usr/sbin/useradd -m -U -s /bin/bash vcap \
	&& /usr/bin/sed -i s/RC_LANG=\"en_US.UTF-8\"/RC_LANG=\"\"/ /etc/sysconfig/language \
	&& mkdir -p /home/vcap/app/node 
#
# /usr/sbin/useradd -m -U -s /bin/bash vcap
#
# /usr/bin/sed -i s/RC_LANG=\"en_US.UTF-8\"/RC_LANG=\"\"/ /etc/sysconfig/language
#
# zypper in nodejs8
# zypper in npm8
#
# npm config set @sap:registry "https://npm.sap.com/" ; npm config set registry "https://registry.npmjs.org/" ; npm config set strict-ssl true
#
# mkdir -p /home/vcap/app/node
#
COPY entrypoint.sh /usr/local/bin/
COPY start_nodejs.sh /usr/local/bin/
COPY node /home/vcap/app/node/
#
RUN npm config set @sap:registry "https://npm.sap.com/" ; npm config set registry "https://registry.npmjs.org/" ; npm config set strict-ssl true \
	&& cd /home/vcap/app/node \
# Do an npm install in the app/node folder before the Docker build
#	&& npm install \
	&& chown -R vcap:vcap /home/vcap/app 
# 
EXPOSE 8080
#
#run!
ENTRYPOINT ["entrypoint.sh"]
