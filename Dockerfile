ARG  FROMIMAGE=cp.icr.io/cp/appc/ace:12.0.8.0-r1
FROM ${FROMIMAGE}

# docker build -t quay.io/trevor_dolby/ace-ping-application:latest .


ADD PingApplication /tmp/PingApplication

RUN export LICENSE=accept && \ 
    . /opt/ibm/ace-12/server/bin/mqsiprofile && \
    ibmint deploy --input-path /tmp/PingApplication --output-work-directory /home/aceuser/ace-server && \
    ibmint optimize server --work-dir /home/aceuser/ace-server --disable NodeJS

# Fix openshift userid randomization
RUN chmod -R 777 /home/aceuser/ace-server
