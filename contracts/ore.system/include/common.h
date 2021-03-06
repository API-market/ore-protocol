#pragma once

/*#include <eosiolib/eosio.hpp>
#include <eosiolib/asset.hpp>*/

using namespace eosio;
using std::string;
using std::vector;

namespace common
{
   static const symbol S_RAM = symbol("RAMCORE", 4);
   static const symbol core_symbol = symbol("SYS", 4);
   static const symbol ore_symbol = symbol("ORE", 4);
   static const name ore_system = name("oresystem");

   /**********************************************/
   /***                                        ***/
   /***            RAM calculations            ***/
   /***                                        ***/
   /**********************************************/

   struct rammarket
   {
      asset supply;

      struct connector
      {
         asset balance;
         double weight = .5;
      };

      connector base;
      connector quote;

      uint64_t primary_key() const { return supply.symbol.raw(); }
   };

   typedef eosio::multi_index<"rammarket"_n, rammarket> RamInfo;

   /***
     * Returns the price of ram for given bytes
     */

   asset getRamCost(uint64_t ram_bytes)
   {
      RamInfo ramInfo(name("eosio"), name("eosio").value);
      auto ramData = ramInfo.find(S_RAM.raw());
      symbol coreSymbol = core_symbol;
      check(ramData != ramInfo.end(), "Could not get RAM info");

      uint64_t base = ramData->base.balance.amount;
      uint64_t quote = ramData->quote.balance.amount;
      return asset((((double)quote / base)) * ram_bytes, coreSymbol);
   }

   struct user_resources
   {
      name owner;
      asset net_weight;
      asset cpu_weight;
      int64_t ram_bytes = 0;

      bool is_empty() const { return net_weight.amount == 0 && cpu_weight.amount == 0 && ram_bytes == 0; }
      uint64_t primary_key() const { return owner.value; }
   };

   typedef eosio::multi_index<"userres"_n, user_resources> user_resources_table;

   asset getAccountCpu(name account)
   {
      user_resources_table _userres(name("eosio"), account.value);
      auto res_itr = _userres.find(account.value);
      return res_itr->cpu_weight;
   }
   asset getAccountNet(name account)
   {
      user_resources_table _userres(name("eosio"), account.value);
      auto res_itr = _userres.find(account.value);
      return res_itr->net_weight;
   }
   uint64_t getAccountRamBytes(name account)
   {
      user_resources_table _userres(name("eosio"), account.value);
      auto res_itr = _userres.find(account.value);
      return res_itr->ram_bytes;
   }

   struct account
   {
      asset balance;

      uint64_t primary_key() const { return balance.symbol.code().raw(); }
   };
   typedef eosio::multi_index<"accounts"_n, account> balance_table;

   asset getSYSBalance(name account)
   {
      balance_table _balance(name("eosio.token"), account.value);
      auto balance_itr = _balance.find(core_symbol.code().raw());
      if (balance_itr == _balance.end())
      {
         return asset(0, core_symbol);
      }
      else
      {
         return balance_itr->balance;
      }
   }

   struct [[eosio::table]] stake_info
   {
      asset amount;
      name staker;

      uint64_t primary_key() const { return amount.symbol.code().raw(); }
   };
   typedef eosio::multi_index<"stakeinfo"_n, stake_info> stakeinfo;

   name getStakerName(name account){
      stakeinfo _info(name("eosio.token"), account.value);
      auto stake_itr = _info.find(ore_symbol.code().raw());
      if(stake_itr == _info.end()){
         return name("");
      } else {
         return stake_itr->staker;
      }
   }

   asset getStakedAmount(name account){
      stakeinfo _info(name("eosio.token"), account.value);
      auto stake_itr = _info.find(ore_symbol.code().raw());
      if(stake_itr == _info.end()){
         return asset(0, ore_symbol);
      } else {
         return stake_itr->amount;
      }
   }

}; // namespace common