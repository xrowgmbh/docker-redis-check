FROM amd64/redis
WORKDIR /data

FROM openshift/origin-cli
WORKDIR /

ENV REDIS_HOST="localhost"

FROM centos:latest 
WORKDIR /root/
COPY --from=0 /data/redis-cli /usr/bin/redis-cli
COPY --from=1 /usr/bin/oc /usr/bin/oc
RUN chmod +x /usr/bin/redis-cli
RUN chmod +x /usr/bin/oc
COPY check /usr/bin/check
RUN chmod +x /usr/bin/check

CMD ["check"]
