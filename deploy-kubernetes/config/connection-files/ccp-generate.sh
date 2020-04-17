#!/bin/bash

function one_line_pem {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}


function json_ccp_org1 {
    local PP=$(one_line_pem $1)
    local CP=$(one_line_pem $2)
    local OP=$(one_line_pem $3)
    sed -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        -e "s#\${OPEM}#$OP#" \
        org1-ccp-template.json
}

PEERPEM=./org1/tlsca.org1.example.com-cert.pem
OPEM=./tlsca.example.com-cert.pem
CAPEM=./org1/ca.org1.example.com-cert.pem

echo "$(json_ccp_org1 $PEERPEM $CAPEM $OPEM)" > ./connection-org1.json


function json_ccp_org2 {
    local PP=$(one_line_pem $1)
    local CP=$(one_line_pem $2)
    local OP=$(one_line_pem $3)
    sed -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        -e "s#\${OPEM}#$OP#" \
        org2-ccp-template.json
}

PEERPEM=./org2/tlsca.org2.example.com-cert.pem
OPEM=./tlsca.example.com-cert.pem
CAPEM=./org2/ca.org2.example.com-cert.pem

echo "$(json_ccp_org2 $PEERPEM $CAPEM $OPEM)" > ./connection-org2.json


function json_ccp_org3 {
    local PP=$(one_line_pem $1)
    local CP=$(one_line_pem $2)
    local OP=$(one_line_pem $3)
    sed -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        -e "s#\${OPEM}#$OP#" \
        org3-ccp-template.json
}

PEERPEM=./org3/tlsca.org3.example.com-cert.pem
OPEM=./tlsca.example.com-cert.pem
CAPEM=./org3/ca.org3.example.com-cert.pem

echo "$(json_ccp_org3 $PEERPEM $CAPEM $OPEM)" > ./connection-org3.json


function json_ccp_org4 {
    local PP=$(one_line_pem $1)
    local CP=$(one_line_pem $2)
    local OP=$(one_line_pem $3)
    sed -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        -e "s#\${OPEM}#$OP#" \
        org4-ccp-template.json
}

PEERPEM=./org4/tlsca.org4.example.com-cert.pem
OPEM=./tlsca.example.com-cert.pem
CAPEM=./org4/ca.org4.example.com-cert.pem

echo "$(json_ccp_org4 $PEERPEM $CAPEM $OPEM)" > ./connection-org4.json

