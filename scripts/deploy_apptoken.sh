#!/bin/bash
cleos=cleos -u https://ore.openrights.exchange:443

ore_contracts=~/ore-protocol/contracts

$cleos wallet unlock -n local --password ...

$cleos system newaccount ore --transfer apptoken.ore EOS8UiZ2oRLoSW6ZaPMCjdEjSTv3wz7Ni3T2gdBBzf3CWBCVTZNXj EOS7e7qsePQoWbhkpYe2Er3eBawpAq86L2DChwpKAVmJYDiH5TK6K --stake-net "10000.0000 SYS" --stake-cpu "10000.0000 SYS" --buy-ram-kbytes 8192 -p ore

$cleos set contract apptoken.ore $ore_contracts/build/ore.apptoken/ ore.apptoken.wasm ore.apptoken.abi
# sleep 3s
$cleos set contract system.ore $ore_contracts/build/ore.system/ ore.system.wasm ore.system.abi

$cleos push action system.ore tokenprice '["10.0000 ORE", "apptoken.ore"]' -p system.ore
