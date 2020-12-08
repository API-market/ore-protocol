#!/bin/bash

eosio_accounts_pubKey="EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV"

ore_accounts_pubKey="EOS7i6tByRWk9LDVWzyUfLfqn6JpRveTuabjd57u3B1f64zHTh3SZ"

cleos create account eosio eosio.bpay $eosio_accounts_pubKey
cleos create account eosio eosio.msig $eosio_accounts_pubKey
cleos create account eosio eosio.names $eosio_accounts_pubKey
cleos create account eosio eosio.ram $eosio_accounts_pubKey
cleos create account eosio eosio.ramfee $eosio_accounts_pubKey
cleos create account eosio eosio.saving $eosio_accounts_pubKey
cleos create account eosio eosio.stake $eosio_accounts_pubKey
cleos create account eosio eosio.token $eosio_accounts_pubKey
cleos create account eosio eosio.vpay $eosio_accounts_pubKey
cleos create account eosio eosio.rex $eosio_accounts_pubKey
cleos create account eosio eosio.wrap $eosio_accounts_pubKey