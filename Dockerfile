FROM alpine:3.18.4

RUN apk add --no-cache curl jq

ARG KUBERNETES_VERSION=v1.28.3
ADD https://dl.k8s.io/$KUBERNETES_VERSION/kubernetes-client-linux-amd64.tar.gz /tmp
RUN tar -xzf /tmp/kubernetes-client-linux-amd64.tar.gz
RUN mv /tmp/kubernetes/client/bin/kubectl /usr/local/bin/kubectl
RUN rm -rf /tmp/kubernetes
RUN rm /tmp/kubernetes-client-linux-amd64.tar.gz
RUN chmod +x /usr/local/bin/kubectl

COPY run.sh /usr/local/bin/k8s-initiator
RUN chmod +x /usr/local/bin/k8s-initiator
ENTRYPOINT /usr/local/bin/k8s-initiator
