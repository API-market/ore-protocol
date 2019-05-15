#!/bin/bash
cleos wallet unlock -n local --password PW5JXJSoWYDgduRFtPx9SEjCaviAZCixgHkVR8nFcwmPjWpBWUyJn
cleos system newaccount eosio --transfer oresystem EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn --stake-net "10000.0000 SYS" --stake-cpu "10000.0000 SYS" --buy-ram-kbytes 8192
cleos system newaccount eosio --transfer syslock EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn --stake-net "10000.0000 SYS" --stake-cpu "10000.0000 SYS" --buy-ram-kbytes 8192

# sleep 3s
cleos set contract oresystem ./contracts/oresystem/build/oresystem/

cleos set account permission producer1 active '{"threshold": 1,"keys": [{"key": "EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn","weight": 1}],"accounts": [{"permission":{"actor":"oresystem","permission":"eosio.code"},"weight":1}]}' owner -p producer1@owner
cleos set account permission oresystem active '{"threshold": 1,"keys": [{"key": "EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn","weight": 1}],"accounts": [{"permission":{"actor":"oresystem","permission":"eosio.code"},"weight":1}]}' owner -p oresystem@owner

cleos push action eosio.token issue '[ "producer1", "1000000000.0000 ORE", "memo" ]' -p eosio@active
cleos push action eosio.token issue '[ "oresystem", "1000000000.0000 ORE", "memo" ]' -p eosio@active
cleos push action eosio.token issue '[ "oresystem", "1000000000.0000 SYS", "memo" ]' -p eosio@active

sleep 3s
cleos push action oresystem setprice '[ "5.0000 ORE", 2, 3584,  "0.2000 ORE"]' -p oresystem

sleep 3s
cleos push action oresystem createoreacc '[ "producer1", "neworeacct11", "EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn", "EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn" ]' -p producer1