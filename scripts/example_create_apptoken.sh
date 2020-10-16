# EXAMPLE to create a new app token (DEMO) owned by new ORE account (demoapphello)
# - Create an ORE account to own the new DEMO token (demoapphello)
cleos push action system.ore createoreacc '{"creator":"app.oreid", "newname":"demoapphello", "ownerkey":"EOS7Rq5JcGyCGQXbRkmHLDpFTti1ZJFhcvU7HeX2m61wTkoHjJAMJ", "activekey":"EOS7Rq5JcGyCGQXbRkmHLDpFTti1ZJFhcvU7HeX2m61wTkoHjJAMJ", "pricekey":1, "referral":"app.oreid"}' -p app.oreid
# - Set permission on token owner account (demoapphello) to let system.ore have eosio.code right - needed by apptoken.ore contract to create a token
cleos set account permission demoapphello active '{"threshold": 1,"keys": [{"key": "EOS7Rq5JcGyCGQXbRkmHLDpFTti1ZJFhcvU7HeX2m61wTkoHjJAMJ","weight": 1}],"accounts": [{"permission":{"actor":"system.ore","permission":"eosio.code"},"weight":1}]}' owner -p demoapphello@owner
# - Fund demoapphello with some ORE (to pay for token creation)
cleos push action eosio.token transfer '["app.oreid", "demoapphello", "20.0000 ORE", "fund ORE tokens"]' -p app.oreid
# - Create the new app token (DEMO) with demoapphello as creator
cleos push action system.ore createtoken '["demoapphello", "10000000000.0000 DEMO"]' -p demoapphello
# - Issue some of the new Demo token
cleos push action apptoken.ore issue '["demoapphello", "100000.0000 DEMO", ""]' -p demoapphello
# - Check balance of DEMO token in demoapphello account
cleos get currency balance apptoken.ore demoapphello DEMO
