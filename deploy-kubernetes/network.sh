cryptogen generate --config /fabric/config/crypto-config.yaml
cp -r crypto-config /fabric/
cp -r /opt/gopath/src/github.com/hyperledger/fabric/core/chaincode/lib/cid /opt/gopath/src/github.com/hyperledger/fabric/core/chaincode/
cp /fabric/config/configtx.yaml /fabric/
cd /fabric
configtxgen -profile TwoOrgsOrdererGenesis -channelID $SYS_CHANNEL -outputBlock genesis.block
configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ${CHANNEL_NAME}.tx -channelID $CHANNEL_NAME
configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate Org1MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org1MSP
configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate Org2MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org2MSP
configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate Org3MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org3MSP
configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate Org4MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org4MSP
