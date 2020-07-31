FROM node
SHELL ["bash", "-c"]
WORKDIR /root
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y python3-pip locales vim curl netcat less git tmux
RUN pip3 install awscli awslogs
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
 && chmod +x kubectl && mv kubectl /usr/local/bin
RUN sed -i -e 's/# ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/' /etc/locale.gen && locale-gen && update-locale LANG=ja_JP.UTF-8 \
 && echo "export LANG=ja_JP.UTF-8" | tee -a /root/.bashrc
RUN npm i -g serverless
RUN mkdir .kube && ln -sfn ../config .kube/config
COPY . .
CMD ["./x"]
