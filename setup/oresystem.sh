#!/bin/bash
cleos=/Users/basarcancelebci/eosio/1.8/bin/cleos

$cleos wallet unlock -n local --password PW5KaVyD3RTq5QER4zHLNXoCxJZLCgMWmvpAiXdwwBvKFp5F1g2TL

$cleos transfer eosio ore "10000000.0000 SYS" "test.com,50,10" -p eosio@active
sleep 1s
$cleos system newaccount ore --transfer system.ore EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn --stake-net "10000.0000 SYS" --stake-cpu "10000.0000 SYS" --buy-ram-kbytes 8192 -p ore
$cleos system newaccount ore --transfer lock.ore EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn --stake-net "10000.0000 SYS" --stake-cpu "10000.0000 SYS" --buy-ram-kbytes 8192 -p ore

# sleep 3s
$cleos set contract system.ore ../contracts/build/ore.system/ ore.system.wasm ore.system.abi

$cleos set account permission producer1 active '{"threshold": 1,"keys": [{"key": "EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn","weight": 1}],"accounts": [{"permission":{"actor":"system.ore","permission":"eosio.code"},"weight":1}]}' owner -p producer1@owner
$cleos set account permission system.ore active '{"threshold": 1,"keys": [{"key": "EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn","weight": 1}],"accounts": [{"permission":{"actor":"system.ore","permission":"eosio.code"},"weight":1}]}' owner -p system.ore@owner
$cleos set account permission lock.ore active '{"threshold": 1,"keys": [{"key": "EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn","weight": 1}],"accounts": [{"permission":{"actor":"system.ore","permission":"eosio.code"},"weight":1}]}' owner -p lock.ore@owner

$cleos transfer eosio producer1 "10000000.0000 ORE" "test.com,50,10" -p eosio@active
$cleos transfer eosio producer1 "10000000.0000 SYS" "test.com,50,10" -p eosio@active
$cleos transfer eosio system.ore "10000000.0000 ORE" "test.com,50,10" -p eosio@active
$cleos transfer eosio system.ore "10000000.0000 SYS" "test.com,50,10" -p eosio@active


sleep 3s
$cleos push action system.ore setprice '[ "5.0000 ORE", 4075, "1.0000 ORE", "1.0000 ORE", 1]' -p system.ore

$cleos push action system.ore setprice '[ "4.0000 ORE", 3048, "0.1000 ORE", "0.1000 ORE", 2]' -p system.ore

#$cleos push action system.ore changetier '["test11111111", 2]' -p test11111111


sleep 3s
$cleos push action system.ore createoreacc '[ "producer1", "neworeacct11", "EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn", "EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn", 1, "producer1"]' -p producer1
$cleos push action system.ore createoreacc '[ "producer1", "neworeacct12", "EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn", "EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn", 1, "producer1"]' -p producer1
$cleos push action system.ore createoreacc '[ "producer1", "neworeacct13", "EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn", "EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn", 1, "producer1"]' -p producer1
$cleos push action system.ore createoreacc '[ "producer1", "neworeacct14", "EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn", "EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn", 1, "producer1"]' -p producer1
$cleos push action system.ore createoreacc '[ "producer1", "neworeacct15", "EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn", "EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn", 1, "producer1"]' -p producer1
$cleos push action system.ore createoreacc '[ "producer1", "test11111111", "EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn", "EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn", 1, "producer1"]' -p producer1
