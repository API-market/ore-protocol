#include <eosiolib/eosio.hpp>
#include <eosiolib/asset.hpp>
#include <eosiolib/ignore.hpp>
#include "accounts.h"
#include "common.h"
using namespace eosio;
using namespace std;
CONTRACT systemore : public contract {
   public:
      using contract::contract;
      systemore( name receiver, name code, datastream<const char*> ds )
         : contract(receiver, code, ds) {}

      ACTION setprice(name funder, asset newaccprice);
      ACTION createoreacc(name creator,
                          name name,
                          accounts::authority& owner,
                          accounts::authority& active,
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


      struct oreprice {
        asset newaccprice;
        name funder;
      };

      oreprice pricetable;
};
