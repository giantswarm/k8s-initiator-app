FROM alpine:3.8

RUN apk add --no-cache curl jq

ARG KUBERNETES_VERSION=v1.15.4
ADD https://storage.googleapis.com/kubernetes-release/release/$KUBERNETES_VERSION/bin/linux/amd64/kubectl /usr/local/bin
RUN chmod +x /usr/local/bin/kubectl

COPY run.sh /usr/local/bin/k8s-initiator
RUN chmod +x /usr/local/bin/k8s-initiator
ENTRYPOINT /usr/local/bin/k8s-initiator
