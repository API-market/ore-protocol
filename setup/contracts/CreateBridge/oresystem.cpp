#include <eosiolib/eosio.hpp>
#include <eosiolib/print.hpp>
#include <eosiolib/action.hpp>

#include "lib/common.h"
#include "lib/publickey.h"

#include "models/accounts.h"
#include "models/balances.h"
#include "models/registry.h"

using namespace eosio;
using namespace common;
using namespace accounts;
using namespace registry;
using namespace balances;
using namespace std;

CONTRACT oresystem : contract, public createaccounts{
private:
    oreaccprice newaccprice;

public:
    using contract::contract;
    oresystem(name receiver, name code,  datastream<const char*> ds):contract(receiver, code, ds),
        newaccprice(_self, _self.value){}

    ACTION createAccount(name& account, accounts::authority& ownerauth, accounts::authority& activeauth, asset& ram, asset& net, asset& cpu){
        accounts::newaccount new_account = accounts::newaccount{
            .creator = createbridge,
            .name = account,
            .owner = ownerauth,
            .active = activeauth
        };

        name newAccountContract = common::getNewAccountContract();

        action(
            permission_level{ createbridge, "active"_n },
            newAccountContract,
            name("newaccount"),
            new_account
        ).send();

        action(
            permission_level{ createbridge, "active"_n },
            newAccountContract,
            name("buyram"),
            make_tuple(createbridge, account, ram)
        ).send();

        action(
            permission_level{ createbridge, "active"_n },
            newAccountContract,
            name("delegatebw"),
            make_tuple(createbridge, account, net, cpu, true)
        ).send();
    };
   

};

EOSIO_DISPATCH( oresystem, (init)(clean)(create)(define)(whitelist)(reclaim))