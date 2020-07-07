FROM docker:dind

WORKDIR /workdir

RUN apk update && \
    apk upgrade && \
    apk add --no-cache gettext && \
    # Install aws cli
    apk add --no-cache -q curl unzip python3 groff && \
    curl -sO https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py && \
    pip3 install awscli --upgrade && \
    rm get-pip.py && \
    # Install kubectl
    curl -s https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/kubectl -o kubectl && \
    chmod +x ./kubectl && \
    mv kubectl /usr/local/bin

COPY . .

