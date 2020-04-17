
function replace {
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${ORG_}/$1/" \
        -e "s/\${PRIVATE_KEY}/$2/" \
        kubernetes/example-ca_deploy.yaml | sed -e $'s/\\\\n/\\\n        /g'
}

# kubectl apply -f kubernetes/fabric-example_pv.yaml

kubectl apply -f kubernetes/fabric-example_pvc.yaml

kubectl apply -f kubernetes/backup-example-org1-peer0_pv.yaml

kubectl apply -f kubernetes/backup-example-org1-peer0_pvc.yaml

kubectl apply -f kubernetes/backup-example-org2-peer0_pv.yaml

kubectl apply -f kubernetes/backup-example-org2-peer0_pvc.yaml

kubectl apply -f kubernetes/backup-example-org3-peer0_pv.yaml

kubectl apply -f kubernetes/backup-example-org3-peer0_pvc.yaml

kubectl apply -f kubernetes/backup-example-org4-peer0_pv.yaml

kubectl apply -f kubernetes/backup-example-org4-peer0_pvc.yaml

kubectl apply -f kubernetes/backup-example-orderer_pv.yaml

kubectl apply -f kubernetes/backup-example-orderer_pvc.yaml

kubectl apply -f kubernetes/fabric-example-tools.yaml

sleep 3

kubectl exec -it fabric-example-tools -- mkdir /fabric/config

kubectl cp ./network.sh fabric-example-tools:/

kubectl cp ./chaincode.sh fabric-example-tools:/

kubectl cp config/configtx.yaml fabric-example-tools:/fabric/config/

kubectl cp config/crypto-config.yaml fabric-example-tools:/fabric/config/

kubectl cp config/chaincode/ fabric-example-tools:/fabric/config/

kubectl exec -it fabric-example-tools -- mkdir -p /opt/gopath/src/github.com/hyperledger

kubectl cp ~/go/src/github.com/hyperledger/fabric  fabric-example-tools:/opt/gopath/src/github.com/hyperledger/

kubectl cp ~/go/src/github.com/golang  fabric-example-tools:/opt/gopath/src/github.com/

kubectl exec -it fabric-example-tools -- /bin/bash network.sh

sleep 1

kubectl cp fabric-example-tools:/fabric/crypto-config/ordererOrganizations/example.com/tlsca/tlsca.example.com-cert.pem ./config/connection-files/tlsca.example.com-cert.pem

kubectl cp fabric-example-tools:/fabric/crypto-config/peerOrganizations/org1.example.com/tlsca/tlsca.org1.example.com-cert.pem ./config/connection-files/org1/tlsca.org1.example.com-cert.pem
kubectl cp fabric-example-tools:/fabric/crypto-config/peerOrganizations/org1.example.com/ca/ca.org1.example.com-cert.pem ./config/connection-files/org1/ca.org1.example.com-cert.pem
kubectl cp fabric-example-tools:/fabric/crypto-config/peerOrganizations/org2.example.com/tlsca/tlsca.org2.example.com-cert.pem ./config/connection-files/org2/tlsca.org2.example.com-cert.pem
kubectl cp fabric-example-tools:/fabric/crypto-config/peerOrganizations/org2.example.com/ca/ca.org2.example.com-cert.pem ./config/connection-files/org2/ca.org2.example.com-cert.pem
kubectl cp fabric-example-tools:/fabric/crypto-config/peerOrganizations/org3.example.com/tlsca/tlsca.org3.example.com-cert.pem ./config/connection-files/org3/tlsca.org3.example.com-cert.pem
kubectl cp fabric-example-tools:/fabric/crypto-config/peerOrganizations/org3.example.com/ca/ca.org3.example.com-cert.pem ./config/connection-files/org3/ca.org3.example.com-cert.pem
kubectl cp fabric-example-tools:/fabric/crypto-config/peerOrganizations/org4.example.com/tlsca/tlsca.org4.example.com-cert.pem ./config/connection-files/org4/tlsca.org4.example.com-cert.pem
kubectl cp fabric-example-tools:/fabric/crypto-config/peerOrganizations/org4.example.com/ca/ca.org4.example.com-cert.pem ./config/connection-files/org4/ca.org4.example.com-cert.pem

cd config/connection-files
chmod 777 *
./ccp-generate.sh
cd ../..


export PRIVATE_KEY=$(kubectl exec -it fabric-example-tools -- ls /fabric/crypto-config/peerOrganizations/org1.example.com/ca/ | grep ".*_sk")
echo "$(replace org1 $PRIVATE_KEY)" > kubernetes/example-org1-ca_deploy.yaml

kubectl apply -f kubernetes/example-org1-ca_deploy.yaml
kubectl apply -f kubernetes/example-org1-ca_svc.yaml


export PRIVATE_KEY=$(kubectl exec -it fabric-example-tools -- ls /fabric/crypto-config/peerOrganizations/org2.example.com/ca/ | grep ".*_sk")
echo "$(replace org2 $PRIVATE_KEY)" > kubernetes/example-org2-ca_deploy.yaml

kubectl apply -f kubernetes/example-org2-ca_deploy.yaml
kubectl apply -f kubernetes/example-org2-ca_svc.yaml


export PRIVATE_KEY=$(kubectl exec -it fabric-example-tools -- ls /fabric/crypto-config/peerOrganizations/org3.example.com/ca/ | grep ".*_sk")
echo "$(replace org3 $PRIVATE_KEY)" > kubernetes/example-org3-ca_deploy.yaml

kubectl apply -f kubernetes/example-org3-ca_deploy.yaml
kubectl apply -f kubernetes/example-org3-ca_svc.yaml


export PRIVATE_KEY=$(kubectl exec -it fabric-example-tools -- ls /fabric/crypto-config/peerOrganizations/org4.example.com/ca/ | grep ".*_sk")
echo "$(replace org4 $PRIVATE_KEY)" > kubernetes/example-org4-ca_deploy.yaml

kubectl apply -f kubernetes/example-org4-ca_deploy.yaml
kubectl apply -f kubernetes/example-org4-ca_svc.yaml

kubectl apply -f kubernetes/example-orderer_deploy.yaml
kubectl apply -f kubernetes/example-orderer_svc.yaml

kubectl apply -f kubernetes/example-org1-peer0_deploy.yaml
kubectl apply -f kubernetes/example-org1-peer0_svc.yaml

kubectl apply -f kubernetes/example-org2-peer0_deploy.yaml
kubectl apply -f kubernetes/example-org2-peer0_svc.yaml

kubectl apply -f kubernetes/example-org3-peer0_deploy.yaml
kubectl apply -f kubernetes/example-org3-peer0_svc.yaml

kubectl apply -f kubernetes/example-org4-peer0_deploy.yaml
kubectl apply -f kubernetes/example-org4-peer0_svc.yaml

sleep 3

kubectl exec -it fabric-example-tools -- /bin/bash chaincode.sh