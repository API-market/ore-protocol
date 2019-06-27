#pragma once
#include <eosiolib/eosio.hpp>
#include <eosiolib/asset.hpp>

using namespace eosio;
using std::string;
using std::vector;

namespace common {
    static const symbol S_RAM = symbol("RAMCORE", 4);

    inline static uint64_t toUUID(string username){
        return std::hash<string>{}(username);
    }


    struct rammarket {
        asset    supply;

        struct connector {
            asset balance;
            double weight = .5;
        };

        connector base;
        connector quote;

        uint64_t primary_key()const { return supply.symbol.raw(); }
    };

    typedef eosio::multi_index<"rammarket"_n, rammarket> RamInfo;

    /***
     * Returns the price of ram for given bytes
     */

    asset getRamCost(uint64_t ram_bytes){
       RamInfo ramInfo(name("eosio"), name("eosio").value);
       auto ramData = ramInfo.find(S_RAM.raw());
       symbol coreSymbol = symbol("SYS", 4);
       eosio_assert(ramData != ramInfo.end(), "Could not get RAM info");

       uint64_t base = ramData->base.balance.amount;
       print("\nbase\n");
       print(std::to_string(base));
       uint64_t quote = ramData->quote.balance.amount;
       return asset((((double)quote / base))*ram_bytes, coreSymbol);
    }
};