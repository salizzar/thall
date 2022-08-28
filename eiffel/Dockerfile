FROM eiffel/eiffel:21.11


EXPOSE 8000


ENV ISE_LIBRARY_PROJECTS=/home/eiffel
ENV EWF_STABLE_VERSION=v1.1.1


WORKDIR /app
COPY app /app/app
ADD app.ecf /app


USER root
RUN apt-get update && \
    apt-get install -y git fcgiwrap nginx && \
    groupadd --system nginx && \
    adduser --system --disabled-password --no-create-home nginx && \
    usermod --group nginx nginx && \
    mkdir -p /var/lib/nginx /var/log/nginx && \
    touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/lib/nginx /var/log/nginx /var/run/nginx.pid


ADD etc/nginx/conf.d/fcgiwrap.conf /etc/nginx/conf.d
ADD etc/init.d/fcgiwrap /etc/init.d
ADD etc/nginx/nginx.conf /etc/nginx


USER eiffel
RUN git clone https://github.com/EiffelWebFramework/EWF.git ${ISE_LIBRARY_PROJECTS}/EWF && \
    cd ${ISE_LIBRARY_PROJECTS}/EWF && git reset --hard ${EWF_STABLE_VERSION} && \
    git clone https://github.com/eiffelhub/json.git ${ISE_LIBRARY_PROJECTS}/json && \
    cd /app && \
    ec -version && \
    ec -stop -freeze -target app -config app.ecf


RUN cd /app/EIFGENs/app/W_code && finish_freezing && \
    mkdir /app/bin && cp app /app/bin && \
    chmod 744 /app/bin


USER nginx
CMD ["nginx", "-g", "daemon off;"]

