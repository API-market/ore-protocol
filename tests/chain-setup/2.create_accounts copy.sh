#!/bin/bash

cleos=$1
ore_eosio_contracts=/Users/basarcancelebci/Work/API-Market/eosio.contracts.old
eosio_contracts=/Users/basarcancelebci/Work/EOSIO/eosio.contracts-v1.8

$cleos wallet unlock -n local --password PW5KaVyD3RTq5QER4zHLNXoCxJZLCgMWmvpAiXdwwBvKFp5F1g2TL

$cleos create account eosio eosio.bpay EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn
$cleos create account eosio eosio.msig EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn
$cleos create account eosio eosio.names EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn
$cleos create account eosio eosio.ram EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn
$cleos create account eosio eosio.ramfee EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn
$cleos create account eosio eosio.saving EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn
$cleos create account eosio eosio.stake EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn
$cleos create account eosio eosio.token EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn
$cleos create account eosio eosio.vpay EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn
$cleos create account eosio eosio.rex EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn
$cleos create account eosio eosio.wrap EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn


# $cleos create account eosio eosio.jpay EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn
# $cleos create account eosio testest EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn




#sleep 5s
#$cleos set contract eosio $eosio_contracts/build/contracts/eosio.bios/

sleep 1s
$cleos set contract eosio.token $eosio_contracts/build/contracts/eosio.token/

sleep 1s
$cleos set contract eosio.msig $eosio_contracts/build/contracts/eosio.msig/

sleep 1s
$cleos set contract eosio.wrap $eosio_contracts/build/contracts/eosio.wrap/

curl -X POST http://127.0.0.1:8888/v1/producer/schedule_protocol_feature_activations -d '{"protocol_features_to_activate": ["0ec7e080177b2c02b278d5088611686b49d739925a92d9bfcacd7fc6b74053bd"]}' | jq



sleep 3s
$cleos set contract eosio $eosio_contracts/build/contracts/eosio.system/
sleep 3s
$cleos set contract eosio $eosio_contracts/build/contracts/eosio.system/

$cleos push action eosio activate '["f0af56d2c5a48d60a4a5b5c903edfb7db3a736a94ed589d0b797df33ff9d3e1d"]' -p eosio # GET_SENDER
$cleos push action eosio activate '["2652f5f96006294109b3dd0bbde63693f55324af452b799ee137a81a905eed25"]' -p eosio # FORWARD_SETCODE
$cleos push action eosio activate '["8ba52fe7a3956c5cd3a656a3174b931d3bb2abb45578befc59f283ecd816a405"]' -p eosio # ONLY_BILL_FIRST_AUTHORIZER
$cleos push action eosio activate '["ad9e3d8f650687709fd68f4b90b41f7d825a365b02c23a636cef88ac2ac00c43"]' -p eosio # RESTRICT_ACTION_TO_SELF
$cleos push action eosio activate '["68dcaa34c0517d19666e6b33add67351d8c5f69e999ca1e37931bc410a297428"]' -p eosio # DISALLOW_EMPTY_PRODUCER_SCHEDULE
$cleos push action eosio activate '["e0fb64b1085cc5538970158d05a009c24e276fb94e1a0bf6a528b48fbc4ff526"]' -p eosio # FIX_LINKAUTH_RESTRICTION
$cleos push action eosio activate '["ef43112c6543b88db2283a2e077278c315ae2c84719a8b25f25cc88565fbea99"]' -p eosio # REPLACE_DEFERRED
$cleos push action eosio activate '["4a90c00d55454dc5b059055ca213579c6ea856967712a56017487886a4d4cc0f"]' -p eosio # NO_DUPLICATE_DEFERRED_ID
$cleos push action eosio activate '["1a99a59d87e06e09ec5b028a9cbb7749b4a5ad8819004365d02dc4379a8b7241"]' -p eosio # ONLY_LINK_TO_EXISTING_PERMISSION
$cleos push action eosio activate '["4e7bf348da00a945489b2a681749eb56f5de00b900014e137ddae39f48f69d67"]' -p eosio # RAM_RESTRICTIONS

sleep 3s
$cleos push action eosio.token create '[ "eosio", "10000000000.0000 SYS" ]' -p eosio.token@active
                                                   
sleep 1s
$cleos push action eosio.token create '[ "eosio", "10000000000.0000 ORE" ]' -p eosio.token@active

sleep 1s
$cleos push action eosio.token issue '[ "eosio", "1000000000.0000 SYS", "memo" ]' -p eosio@active

sleep 1s
$cleos push action eosio.token issue '[ "eosio", "1000000000.0000 ORE", "memo" ]' -p eosio@active

sleep 3s
$cleos push action eosio init '[0, "4,SYS"]' -p eosio@active

# sleep 3s
$cleos push action eosio setpriv '["eosio.msig", 1]' -p eosio@active

sleep 3s
$cleos set contract eosio $ore_eosio_contracts/build/contracts/eosio.system/
sleep 3s
$cleos set contract eosio $ore_eosio_contracts/build/contracts/eosio.system/

$cleos system newaccount eosio --transfer producer1 EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn --stake-net "100000000.0000 SYS" --stake-cpu "100000000.0000 SYS" --buy-ram-kbytes 8192

$cleos system newaccount eosio --transfer producer2 EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn --stake-net "100000000.0000 SYS" --stake-cpu "100000000.0000 SYS" --buy-ram-kbytes 8192

$cleos system newaccount eosio --transfer producer3 EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn --stake-net "100000000.0000 SYS" --stake-cpu "100000000.0000 SYS" --buy-ram-kbytes 8192
$cleos system newaccount eosio --transfer ore EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn --stake-net "100000000.0000 SYS" --stake-cpu "100000000.0000 SYS" --buy-ram-kbytes 8192

$cleos system newaccount eosio --transfer funds.ore EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn --stake-net "10000.0000 SYS" --stake-cpu "10000.0000 SYS" --buy-ram-kbytes 8192

sleep 3

$cleos system regproducer producer1 EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn https://accountnum11.com
$cleos system regproducer producer2 EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn https://accountnum11.com
$cleos system regproducer producer3 EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn https://accountnum11.com

