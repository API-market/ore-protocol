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
class [[eosio::contract("ore.system")]] oresystem : public contract
{
private:
   TABLE oreprice
   {
      uint64_t key;
      asset createprice;            // newaccount price as ORE
      uint64_t rambytes;            // initial amount of ram
      asset netamount;              // initial amount of net
      asset cpuamount;              // initial amount of cpu
      uint64_t bwpricerate;         // ORE to SYS ratio for system resource delegations

      uint64_t primary_key() const { return key; }
      EOSLIB_SERIALIZE(oreprice, (key)(createprice)(rambytes)(netamount)(cpuamount)(bwpricerate))
   };

   typedef eosio::multi_index<"oreprice"_n, oreprice> orepricetable;

public:
   using contract::contract;
   oresystem(name receiver, name code, datastream<const char *> ds)
       : contract(receiver, code, ds), _prices(receiver, receiver.value) {}

   ACTION setprice(asset createprice, uint64_t rambytes, asset netamount, asset cpuamount, uint64_t bwpricerate);
   ACTION createoreacc(name creator,
                        name newname,
                        public_key &ownerkey,
                        public_key &activekey);
   ACTION delegatebw(name from, name receiver,
                     asset stake_net_quantity, 
                     asset stake_cpu_quantity);
   ACTION undelegatebw(name from, name receiver,
                       asset unstake_net_quantity, 
                       asset unstake_cpu_quantity);
   ACTION buyram(name payer, name receiver, asset quant);
   ACTION buyrambytes(name payer, name receiver, uint32_t bytes);
   ACTION sellram(name account, int64_t bytes);

   orepricetable _prices;

   //possibly different accounts that has different uses
   static constexpr name token_account{"eosio.token"_n};
   static constexpr name ore_system{"oresystem"_n};
   static constexpr name sys_lock{"oresystem"_n};
   static constexpr name ore_lock{"oresystem"_n};
   static constexpr name sys_payer{"oresystem"_n};
   static constexpr symbol ore_symbol = symbol(symbol_code("ORE"), 4);
   static constexpr symbol sys_symbol = symbol(symbol_code("SYS"), 4);
};
