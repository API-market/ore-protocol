#!/bin/bash

cleos wallet unlock -n local --password PW5JXJSoWYDgduRFtPx9SEjCaviAZCixgHkVR8nFcwmPjWpBWUyJn

cleos create account eosio eosio.bpay EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn
cleos create account eosio eosio.msig EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn
cleos create account eosio eosio.names EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn
cleos create account eosio eosio.ram EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn
cleos create account eosio eosio.ramfee EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn
cleos create account eosio eosio.saving EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn
cleos create account eosio eosio.stake EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn
cleos create account eosio eosio.token EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn
cleos create account eosio eosio.vpay EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn
cleos create account eosio eosio.rex EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn


# cleos create account eosio eosio.jpay EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn
# cleos create account eosio testest EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn


sleep 1s
cleos set contract eosio.token ./contracts/eosio.contracts/build/eosio.token/

sleep 1s
cleos set contract eosio.msig ./contracts/eosio.contracts/build/eosio.msig/

sleep 1s
cleos push action eosio.token create '[ "eosio", "10000000000.0000 SYS" ]' -p eosio.token@active

sleep 3s
cleos push action eosio.token issue '[ "eosio", "1000000000.0000 SYS", "memo" ]' -p eosio@active

sleep 1s
cleos push action eosio.token create '[ "eosio", "10000000000.0000 ORE" ]' -p eosio.token@active

sleep 3s
cleos push action eosio.token issue '[ "eosio", "1000000000.0000 ORE", "memo" ]' -p eosio@active

cleos create account eosio eosio.mex EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn

sleep 3s
cleos set contract eosio ./contracts/eosio.contracts/build/eosio.system/

sleep 3s
cleos push action eosio setpriv '["eosio.msig", 1]' -p eosio@active
cleos push action eosio init '["0", "4,SYS"]' -p eosio@active

cleos system newaccount eosio --transfer producer1 EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn --stake-net "100000000.0000 SYS" --stake-cpu "100000000.0000 SYS" --buy-ram-kbytes 8192

cleos system newaccount eosio --transfer producer2 EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn --stake-net "100000000.0000 SYS" --stake-cpu "100000000.0000 SYS" --buy-ram-kbytes 8192

cleos system newaccount eosio --transfer producer3 EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn --stake-net "100000000.0000 SYS" --stake-cpu "100000000.0000 SYS" --buy-ram-kbytes 8192

cleos system newaccount eosio --transfer orefunds EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn --stake-net "10000.0000 SYS" --stake-cpu "10000.0000 SYS" --buy-ram-kbytes 8192

sleep 3

cleos system regproducer producer1 EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn https://accountnum11.com
#cleos system regproducer producer2 EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn https://accountnum11.com
#cleos system regproducer producer3 EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn https://accountnum11.com
