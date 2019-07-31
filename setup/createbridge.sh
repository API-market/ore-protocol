#!/bin/bash
CHAIN_SYMBOL=${1:-ORE}
SYMBOL_PRECISION=${2:-4}

cleos=/Users/basarcancelebci/eosio/1.8/bin/cleos

$cleos wallet unlock -n local --password PW5KaVyD3RTq5QER4zHLNXoCxJZLCgMWmvpAiXdwwBvKFp5F1g2TL
$cleos system newaccount eosio --transfer createbridge EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn --stake-net "10000.0000 SYS" --stake-cpu "10000.0000 SYS" --buy-ram-kbytes 8192

# sleep 3s
$cleos set contract createbridge ../../CreateBridge/build/ createbridge.wasm createbridge.abi

$cleos set account permission createbridge active \
'{"threshold": 1,"keys": [{"key": "EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn","weight": 1}],"accounts": [{"permission":{"actor":"createbridge","permission":"eosio.code"},"weight":1}, {"permission":{"actor":"system.ore","permission":"eosio.code"},"weight":1}]}' owner

#$cleos set account permission system.ore active '{"threshold": 1,"keys": [{"key": "EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn","weight": 1}],"accounts": [{"permission":{"actor":"createbridge","permission":"eosio.code"},"weight":1}]}' owner -p system.ore@owner

sleep 3s
$cleos push action createbridge init '["'$SYMBOL_PRECISION','$CHAIN_SYMBOL'","system.ore","createoreacc", 0]' -p createbridge
#$cleos push action createbridge init '["4,ORE","system.ore","createoreacc", 0]' -p createbridge

sleep 3s
$cleos push action createbridge define '{"owner":"system.ore", "dapp":"test.com", "ram_bytes":0, "net":"0.2000 ORE", "cpu":"0.2000 ORE", "pricekey":1, "airdrop":{"contract": "", "tokens": "1.0000 ORE", "limit": "10.0000 ORE"}}' -p system.ore
sleep 3s
$cleos transfer system.ore createbridge "100.0000 ORE" "test.com,50,10" -p system.ore

sleep 3s
$cleos push action createbridge create '["system.ore","producer4231","EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn","EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn","test.com","producer1"]' -p system.ore
