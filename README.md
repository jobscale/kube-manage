# Kubernetes management port forwarding container

### Example
```
cp ~/.kube/config .
docker build . -t local/kube-manage
docker run --name kube-manage -p 8080:8080 -p 8081:8081 -p 80:80 -p 443:443 -p 3306:3306 -d local/kube-manage
docker update --restart=always kube-manage
```
