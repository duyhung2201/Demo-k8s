# 1. Start minikube à pull images

```bash
minikuber start
eval $(minikube docker-env)
```
```bash
docker pull hyperledger/fabric-tools:1.4.4
```
```bash
docker pull hyperledger/fabric-peer:1.4.4
```
```bash
docker pull hyperledger/fabric-orderer:1.4.4
```
```bash
docker pull hyperledger/fabric-ca:1.4.4
```

# 2. Up network

```bash
./scripts.sh
```

# 3. Connect from sdk
Các file connection-org1.json, connection-org2.json, connection-org3.json, connection-org4.json

# 4. Clear network - xóa đúng thứ tự các lệnh sau

```bash
kubectl delete svc --all
```

```bash
kubectl delete deployment --all
```

```bash
kubectl delete pod --all
```

```bash
kubectl delete pvc --all
```

```bash
kubectl delete pv --all
```
