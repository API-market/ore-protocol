#include <eosiolib/eosio.hpp>
#include <eosiolib/asset.hpp>
#include <eosiolib/ignore.hpp>
#include "accounts.h"
#include "common.h"
#include "publickey.h"
using namespace eosio;
using namespace std;
using namespace accounts;
using namespace common;
CONTRACT oresystem : public contract {
   public:
      using contract::contract;
      oresystem( name receiver, name code, datastream<const char*> ds )
         : contract(receiver, code, ds) {}

      ACTION setprice(name funder, asset newaccprice);
      ACTION createoreacc(name creator,
                          name name,
                          public_key& owner,
                          public_key& active,
                          asset ramquant,
                          asset stake_net_quantity,
                          asset stake_cpu_quantity);
      ACTION delegatebw(name from, name receiver,
                                     asset stake_net_quantity, asset stake_cpu_quantity);
      ACTION undelegatebw(name from, name receiver,
                                       asset unstake_net_quantity, asset unstake_cpu_quantity);
      ACTION buyram(name payer, name receiver, asset quant);
      ACTION buyrambytes(name payer, name receiver, uint32_t bytes);
      ACTION sellram(name account, int64_t bytes);
      ACTION claimrewards(const name owner);

      name funder;
      asset createprice;
};
