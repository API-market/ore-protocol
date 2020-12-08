#!/bin/bash

cd genesis
./genesis_start.sh

cd ../producer1
./genesis_start.sh

cleos wallet create -n oretest -f /ore-data/walletpw.txt

cleos wallet import -n oretest --private-key 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3
cleos wallet import -n oretest --private-key 5JUzsJi7rARZy2rT5eHhcdUKTyVPvaksnEKtNWzyiBbifJA1dUW
cleos wallet import -n oretest --private-key 5HrMPq41QRVWbQhWvtcxBKLAS5RkksP71q4MumAt2Pdk5SrPpDG
