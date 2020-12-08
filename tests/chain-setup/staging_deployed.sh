#!/bin/bash

cleos=$1
eosio_contracts=$2
ore_contracts=$3

$cleos wallet unlock -n local --password PW5KaVyD3RTq5QER4zHLNXoCxJZLCgMWmvpAiXdwwBvKFp5F1g2TL

$cleos system newaccount eosio --transfer eosio.upay EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn --stake-net "10000.0000 SYS" --stake-cpu "10000.0000 SYS" --buy-ram-kbytes 8192 -p eosio

$cleos set contract eosio $eosio_contracts/build/contracts/eosio.system/

$cleos set contract eosio.token $eosio_contracts/build/contracts/eosio.token/

# sleep 3s
$cleos set contract system.ore $ore_contracts/build/ore.system/ ore.system.wasm ore.system.abi

$cleos push action eosio setram '[10737418240]' -p eosio # 10 Gib

$cleos push action eosio.token open '["eosio.upay", "4,ORE", "eosio"]' -p eosio@active

$cleos push action eosio.token setstaked '["0.0000 ORE"]' -p eosio.token@active

$cleos push action eosio setinflation '[0, 10000, 10000]' -p eosio@active

$cleos push action eosio claimrewards '["producer1"]' -p producer1@active