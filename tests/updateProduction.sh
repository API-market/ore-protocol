#!/bin/bash

cleos=cleos

eosio_contracts=/Users/basarcancelebci/Work/API-Market/eosio.contracts

ore_contracts=~/ore-protocol/contracts


echo 'Update production'
./token-economics-update/deploy-production.sh $cleos $eosio_contracts $ore_contracts
