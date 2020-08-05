# Kubernetes management port forwarding container

### Example
```
cp ~/.kube/config .
docker build . -t local/kube-manage
docker run --name kube-manage -p 443:443 -p 80:80 -d local/kube-manage
docker update --restart=always kube-manage
```
