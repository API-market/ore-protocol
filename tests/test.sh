#!/bin/bash

eosio_accounts_pubKey="EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV"

ore_accounts_pubKey="EOS7i6tByRWk9LDVWzyUfLfqn6JpRveTuabjd57u3B1f64zHTh3SZ"

docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 create account eosio eosio.bpay $eosio_accounts_pubKey
docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 create account eosio eosio.msig $eosio_accounts_pubKey
docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 create account eosio eosio.names $eosio_accounts_pubKey
docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 create account eosio eosio.ram $eosio_accounts_pubKey
docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 create account eosio eosio.ramfee $eosio_accounts_pubKey
docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 create account eosio eosio.saving $eosio_accounts_pubKey
docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 create account eosio eosio.stake $eosio_accounts_pubKey
docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 create account eosio eosio.token $eosio_accounts_pubKey
docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 create account eosio eosio.vpay $eosio_accounts_pubKey
docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 create account eosio eosio.rex $eosio_accounts_pubKey
docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 create account eosio eosio.wrap $eosio_accounts_pubKey


# docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 create account eosio eosio.jpay EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn
# docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 create account eosio testest EOS6H2tjbrS6zm8d3tX6yeHorEoihP23Ny9c9wFRHGfJp4vtD42rn




#sleep 5s
docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 set contract eosio /root/contracts/old-contracts/eosio.contracts/build/eosio.bios/

sleep 1s
docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 set contract eosio.token /root/contracts/old-contracts/eosio.contracts/build/eosio.token/

sleep 1s
docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 set contract eosio.msig /root/contracts/old-contracts/eosio.contracts/build/eosio.msig/

sleep 1s
docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 set contract eosio.wrap /root/contracts/old-contracts/eosio.contracts/build/eosio.wrap/

docker exec -it ore-main curl -X POST http://127.0.0.1:8888/v1/producer/schedule_protocol_feature_activations -d '{"protocol_features_to_activate": ["0ec7e080177b2c02b278d5088611686b49d739925a92d9bfcacd7fc6b74053bd"]}' | jq



sleep 3s
docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 set contract eosio /root/contracts/old-contracts/eosio.contracts/build/eosio.system/
sleep 3s
docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 set contract eosio /root/contracts/old-contracts/eosio.contracts/build/eosio.system/



sleep 3s
docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 push action eosio.token create '[ "eosio", "10000000000.0000 SYS" ]' -p eosio.token@active
                                                   
sleep 1s
docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 push action eosio.token create '[ "eosio", "10000000000.0000 ORE" ]' -p eosio.token@active

sleep 1s
docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 push action eosio.token issue '[ "eosio", "1000000000.0000 SYS", "memo" ]' -p eosio@active

sleep 1s
docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 push action eosio.token issue '[ "eosio", "1000000000.0000 ORE", "memo" ]' -p eosio@active

sleep 3s
docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 push action eosio init '[0, "4,SYS"]' -p eosio@active

# sleep 3s
docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 push action eosio setpriv '["eosio.msig", 1]' -p eosio@active

docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 system newaccount eosio --transfer producer1 $ore_accounts_pubKey --stake-net "100000000.0000 SYS" --stake-cpu "100000000.0000 SYS" --buy-ram-kbytes 8192

docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 system newaccount eosio --transfer producer2 $ore_accounts_pubKey --stake-net "100000000.0000 SYS" --stake-cpu "100000000.0000 SYS" --buy-ram-kbytes 8192

docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 system newaccount eosio --transfer producer3 $ore_accounts_pubKey --stake-net "100000000.0000 SYS" --stake-cpu "100000000.0000 SYS" --buy-ram-kbytes 8192
docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 system newaccount eosio --transfer ore $ore_accounts_pubKey --stake-net "100000000.0000 SYS" --stake-cpu "100000000.0000 SYS" --buy-ram-kbytes 8192

docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 system newaccount eosio --transfer funds.ore $ore_accounts_pubKey --stake-net "10000.0000 SYS" --stake-cpu "10000.0000 SYS" --buy-ram-kbytes 8192

sleep 3

docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 system regproducer producer1 $eosio_accounts_pubKey https://accountnum11.com
docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 system regproducer producer2 $eosio_accounts_pubKey https://accountnum11.com
docker exec -it ore-main cleos --url http://127.0.0.1:8888 --wallet-url http://ore-wallet:8901 system regproducer producer3 $eosio_accounts_pubKey https://accountnum11.com

