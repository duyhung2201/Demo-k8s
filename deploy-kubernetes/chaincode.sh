cd /fabric
export ORDERER_URL="example-orderer:31010"
export CORE_PEER_ADDRESSAUTODETECT="false"
export CORE_PEER_NETWORKID="nid1"
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_MSPCONFIGPATH="/fabric/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp"
export FABRIC_CFG_PATH="/etc/hyperledger/fabric"
export CORE_PEER_ADDRESS="example-org1-peer0:30110"
peer channel create -o ${ORDERER_URL} -c ${CHANNEL_NAME} -f /fabric/${CHANNEL_NAME}.tx

sleep 3
cd /
export CORE_PEER_NETWORKID="nid1"
export ORDERER_URL="example-orderer:31010"
export FABRIC_CFG_PATH="/etc/hyperledger/fabric"
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_MSPCONFIGPATH="/fabric/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp"

export CORE_PEER_ADDRESS="example-org1-peer0:30110"
peer channel fetch newest -o ${ORDERER_URL} -c ${CHANNEL_NAME}
peer channel join -b ${CHANNEL_NAME}_newest.block
rm -rf /${CHANNEL_NAME}_newest.block

sleep 3

export CORE_PEER_NETWORKID="nid1"
export ORDERER_URL="example-orderer:31010"
export FABRIC_CFG_PATH="/etc/hyperledger/fabric"
export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_MSPCONFIGPATH="/fabric/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp"

export CORE_PEER_ADDRESS="example-org2-peer0:30210"
peer channel fetch newest -o ${ORDERER_URL} -c ${CHANNEL_NAME}
peer channel join -b ${CHANNEL_NAME}_newest.block
rm -rf /${CHANNEL_NAME}_newest.block

sleep 3

export CORE_PEER_NETWORKID="nid1"
export ORDERER_URL="example-orderer:31010"
export FABRIC_CFG_PATH="/etc/hyperledger/fabric"
export CORE_PEER_LOCALMSPID="Org3MSP"
export CORE_PEER_MSPCONFIGPATH="/fabric/crypto-config/peerOrganizations/org3.example.com/users/Admin@org3.example.com/msp"

export CORE_PEER_ADDRESS="example-org3-peer0:30310"
peer channel fetch newest -o ${ORDERER_URL} -c ${CHANNEL_NAME}
peer channel join -b ${CHANNEL_NAME}_newest.block
rm -rf /${CHANNEL_NAME}_newest.block

sleep 3

export CORE_PEER_NETWORKID="nid1"
export ORDERER_URL="example-orderer:31010"
export FABRIC_CFG_PATH="/etc/hyperledger/fabric"
export CORE_PEER_LOCALMSPID="Org4MSP"
export CORE_PEER_MSPCONFIGPATH="/fabric/crypto-config/peerOrganizations/org4.example.com/users/Admin@org4.example.com/msp"

export CORE_PEER_ADDRESS="example-org4-peer0:30410"
peer channel fetch newest -o ${ORDERER_URL} -c ${CHANNEL_NAME}
peer channel join -b ${CHANNEL_NAME}_newest.block
rm -rf /${CHANNEL_NAME}_newest.block

sleep 3

cp -r /fabric/config/chaincode $GOPATH/src/
export CHAINCODE_NAME="example"
export CHAINCODE_VERSION="1.0"
export FABRIC_CFG_PATH="/etc/hyperledger/fabric"
export CORE_PEER_MSPCONFIGPATH="/fabric/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp"
export CORE_PEER_LOCALMSPID="Org1MSP"

export CORE_PEER_ADDRESS="example-org1-peer0:30110"
peer chaincode install -n ${CHAINCODE_NAME} -l golang -v ${CHAINCODE_VERSION} -p chaincode/example/

sleep 3

cp -r /fabric/config/chaincode $GOPATH/src/
export CHAINCODE_NAME="example"
export CHAINCODE_VERSION="1.0"
export FABRIC_CFG_PATH="/etc/hyperledger/fabric"
export CORE_PEER_MSPCONFIGPATH="/fabric/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp"
export CORE_PEER_LOCALMSPID="Org2MSP"

export CORE_PEER_ADDRESS="example-org2-peer0:30210"
peer chaincode install -n ${CHAINCODE_NAME} -l golang -v ${CHAINCODE_VERSION} -p chaincode/example/

sleep 3

cp -r /fabric/config/chaincode $GOPATH/src/
export CHAINCODE_NAME="example"
export CHAINCODE_VERSION="1.0"
export FABRIC_CFG_PATH="/etc/hyperledger/fabric"
export CORE_PEER_MSPCONFIGPATH="/fabric/crypto-config/peerOrganizations/org3.example.com/users/Admin@org3.example.com/msp"
export CORE_PEER_LOCALMSPID="Org3MSP"

export CORE_PEER_ADDRESS="example-org3-peer0:30310"
peer chaincode install -n ${CHAINCODE_NAME} -l golang -v ${CHAINCODE_VERSION} -p chaincode/example/

sleep 3

cp -r /fabric/config/chaincode $GOPATH/src/
export CHAINCODE_NAME="example"
export CHAINCODE_VERSION="1.0"
export FABRIC_CFG_PATH="/etc/hyperledger/fabric"
export CORE_PEER_MSPCONFIGPATH="/fabric/crypto-config/peerOrganizations/org4.example.com/users/Admin@org4.example.com/msp"
export CORE_PEER_LOCALMSPID="Org4MSP"

export CORE_PEER_ADDRESS="example-org4-peer0:30410"
peer chaincode install -n ${CHAINCODE_NAME} -l golang -v ${CHAINCODE_VERSION} -p chaincode/example/

sleep 3

export CHAINCODE_NAME="example"
export CHAINCODE_VERSION="1.0"
export FABRIC_CFG_PATH="/etc/hyperledger/fabric"
export CORE_PEER_MSPCONFIGPATH="/fabric/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp"
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_ADDRESS="example-org1-peer0:30110"
export ORDERER_URL="example-orderer:31010"
export FABRIC_LOGGING_LEVEL=debug
peer chaincode instantiate -o ${ORDERER_URL} -C ${CHANNEL_NAME} -n ${CHAINCODE_NAME} -l golang -v ${CHAINCODE_VERSION} -c '{"Args":["init","a", "100", "b", "100"]}' -P "OR ('Org1MSP.peer', 'Org2MSP.peer', 'Org3MSP.peer', 'Org4MSP.peer') "

export CORE_PEER_LOCALMSPID="Org1MSP"
export FABRIC_CFG_PATH="/etc/hyperledger/fabric"
export CORE_PEER_MSPCONFIGPATH="/fabric/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp"
export CORE_PEER_ADDRESS="example-org1-peer0:30110"
export ORDERER_URL="example-orderer:31010"
export FABRIC_LOGGING_LEVEL=debug
peer channel update -f /fabric/Org1MSPanchors.tx -c ${CHANNEL_NAME}  -o ${ORDERER_URL}

sleep 3

export CORE_PEER_LOCALMSPID="Org2MSP"
export FABRIC_CFG_PATH="/etc/hyperledger/fabric"
export CORE_PEER_MSPCONFIGPATH="/fabric/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp"
export CORE_PEER_ADDRESS="example-org2-peer0:30210"
export ORDERER_URL="example-orderer:31010"
export FABRIC_LOGGING_LEVEL=debug
peer channel update -f /fabric/Org2MSPanchors.tx -c ${CHANNEL_NAME}  -o ${ORDERER_URL}

sleep 3

export CORE_PEER_LOCALMSPID="Org3MSP"
export FABRIC_CFG_PATH="/etc/hyperledger/fabric"
export CORE_PEER_MSPCONFIGPATH="/fabric/crypto-config/peerOrganizations/org3.example.com/users/Admin@org3.example.com/msp"
export CORE_PEER_ADDRESS="example-org3-peer0:30310"
export ORDERER_URL="example-orderer:31010"
export FABRIC_LOGGING_LEVEL=debug
peer channel update -f /fabric/Org3MSPanchors.tx -c ${CHANNEL_NAME}  -o ${ORDERER_URL}

sleep 3

export CORE_PEER_LOCALMSPID="Org4MSP"
export FABRIC_CFG_PATH="/etc/hyperledger/fabric"
export CORE_PEER_MSPCONFIGPATH="/fabric/crypto-config/peerOrganizations/org4.example.com/users/Admin@org4.example.com/msp"
export CORE_PEER_ADDRESS="example-org4-peer0:30410"
export ORDERER_URL="example-orderer:31010"
export FABRIC_LOGGING_LEVEL=debug
peer channel update -f /fabric/Org4MSPanchors.tx -c ${CHANNEL_NAME}  -o ${ORDERER_URL}

sleep 3

export CHAINCODE_NAME="example"
export FABRIC_CFG_PATH="/etc/hyperledger/fabric"
export ORDERER_URL="example-orderer:31010"
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_MSPCONFIGPATH="/fabric/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp"
export CORE_PEER_ADDRESS="example-org1-peer0:30110"

peer chaincode invoke --peerAddresses ${CORE_PEER_ADDRESS} -o ${ORDERER_URL} -C ${CHANNEL_NAME} -n ${CHAINCODE_NAME} -c '{"Args":["invoke","a","b", "10"]}'
sleep 3
peer chaincode query -C ${CHANNEL_NAME} -n ${CHAINCODE_NAME} -c '{"Args": ["query", "a"]}'