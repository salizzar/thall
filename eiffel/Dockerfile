FROM eiffel/eiffel:latest

EXPOSE 8000

ENV ISE_LIBRARY_PROJECTS=/eiffel

WORKDIR /app

COPY app /app

RUN mkdir /eiffel && \
    git clone https://github.com/eiffelhub/json.git /eiffel/json && \
    git clone https://github.com/EiffelWebFramework/EWF.git /eifell/EWF && git reset --hard v1.1.1 && \
    cd /app && ec -freeze -target app -config app.ecf && \
    cd EIFGENs/app/W_code && finish_freezing \
    mkdir /app/bin && cp app /app/bin

CMD ["/app/bin/app"]
