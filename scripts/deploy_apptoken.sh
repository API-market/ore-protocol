#!/bin/bash
cleos=cleos -u https://ore.openrights.exchange:443

ore_contracts=~/ore-protocol/contracts

$cleos wallet unlock -n local --password ...

$cleos system newaccount ore --transfer apptoken.ore EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn --stake-net "10000.0000 SYS" --stake-cpu "10000.0000 SYS" --buy-ram-kbytes 8192 -p ore

$cleos set contract apptoken.ore $ore_contracts/build/ore.apptoken/ ore.apptoken.wasm ore.apptoken.abi
# sleep 3s
$cleos set contract system.ore $ore_contracts/build/ore.system/ ore.system.wasm ore.system.abi

$cleos push action system.ore tokenprice '["10.0000 ORE", "apptoken"]' -p producer1@active
