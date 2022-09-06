FROM eiffel/eiffel:21.11


EXPOSE 8000


# deb packages
ENV REQUIRED_PACKAGES="vim tmux git nginx fcgiwrap"
ENV DEV_REQUIRED_PACKAGES="build-essential libfcgi-dev openrc net-tools htop procps"


# use root to install / create / setup all required stuff
USER root
RUN  apt-get update && \
     apt-get install -y ${REQUIRED_PACKAGES} ${DEV_REQUIRED_PACKAGES} && \
     groupadd --system nginx && \
     adduser --system --disabled-password --no-create-home nginx && \
     usermod --group nginx nginx && \
     mkdir -p /var/lib/nginx /var/log/nginx && \
     touch /var/run/nginx.pid && chown nginx:nginx /var/run/nginx.pid && \
     chown -R nginx:nginx /var/lib/nginx /var/log/nginx /var/run/nginx.pid /run/openrc/started



# use eiffel from here to store all that Eiffel stuff to build the fcgi app
USER eiffel

ENV ISE_LIBRARY_PROJECTS=/home/eiffel
ENV EWF_STABLE_VERSION=v1.1.1

WORKDIR /app
COPY app /app/app
ADD app.ecf /app

RUN git clone https://github.com/EiffelWebFramework/EWF.git ${ISE_LIBRARY_PROJECTS}/EWF && \
    cd ${ISE_LIBRARY_PROJECTS}/EWF && git reset --hard ${EWF_STABLE_VERSION} && \
    git clone https://github.com/eiffelhub/json.git ${ISE_LIBRARY_PROJECTS}/json && \
    cd /app && \
    mkdir bin && \
    eiffel build -v --target app app.ecf bin/app.fcgi



# came back to root to add / remove all unnecessary stuff
USER root

COPY etc/nginx/conf.d /etc/nginx/conf.d
ADD etc/nginx/nginx.conf /etc/nginx/
ADD etc/init.d/nginx /etc/init.d/nginx
ADD etc/init.d/app /etc/init.d/app
ADD usr/bin/start /usr/bin/

RUN apt-get remove -y ${DEV_REQUIRED_PACKAGES} && \
    apt-get autoremove --purge --yes && \
    apt-get autoclean --yes && \
    unset REQUIRED_PACKAGES DEV_REQUIRED_PACKAGES && \
    chown root:root /etc/init.d/app /etc/init.d/nginx /usr/bin/start && \
    chmod +x /etc/init.d/app /etc/init.d/nginx /usr/bin/start


CMD ["/usr/bin/start"]

