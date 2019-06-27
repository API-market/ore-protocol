#include "system.ore.hpp"

ACTION systemore::setprice(name funder, asset newaccprice)
{
    require_auth(_self);
    oreprice* ptr = &pricetable;

    ptr->funder = funder;
    ptr->newaccprice = newaccprice;
}

ACTION systemore::createoreacc(name creator,
                               name name,
                               accounts::authority &owner,
                               accounts::authority &active,
                               asset ramquant,
                               asset stake_net_quantity,
                               asset stake_cpu_quantity)
{




    // INLINE_ACTION_SENDER(eosio::token, transfer)
    // (
    //     "eosio.token"_n, {{creator, active_permission}},
    //     {creator, itr->funder, itr->newaccprice, std::string("pay ore acc")});

    action(
            permission_level{ creator, "active"_n },
            "eosio.token"_n,
            "transfer"_n,
            make_tuple(creator, pricetable.funder, pricetable.newaccprice, std::string("pay ore acc")))
            .send();

    accounts::newaccount new_account = accounts::newaccount{
            .creator = creator,
            .name = name,
            .owner = owner,
            .active = active
    };

    action(
            permission_level{ creator, "active"_n },
            "eosio"_n,
            "newaccount"_n,
            new_account
        ).send();

    // INLINE_ACTION_SENDER(eosiosystem::system_contract, buyram)
    //     (
    //         "eosio"_n, {{_self, active_permission}},
    //         {_self, newact, ramquant});

    // INLINE_ACTION_SENDER(eosiosystem::system_contract, delegatebw)
    // (
    //     "eosio"_n, {{_self, active_permission}},
    //     {_self, newact, stake_net_quantity, stake_cpu_quantity, true});
}

ACTION systemore::delegatebw(name from, name receiver,
                             asset stake_net_quantity,
                             asset stake_cpu_quantity)

{
    //changebw(from, receiver, stake_net_quantity, stake_cpu_quantity, transfer);
    action(
        permission_level{from, "active"_n},
        "eosio"_n,
        name("delegatebw"),
        make_tuple(from, receiver, stake_net_quantity, stake_cpu_quantity, true))
        .send();
} // delegatebw

ACTION systemore::undelegatebw(name from, name receiver,
                               asset unstake_net_quantity, asset unstake_cpu_quantity)
{
    //changebw(from, receiver, -unstake_net_quantity, -unstake_cpu_quantity, false);

    asset sys_unstake_net, sys_unstake_cpu, oretotal;

    sys_unstake_net.amount = unstake_net_quantity.amount;
    sys_unstake_cpu.amount = unstake_cpu_quantity.amount;
    sys_unstake_net.symbol = symbol("SYS", 4);
    sys_unstake_cpu.symbol = symbol("SYS", 4);

    oretotal.amount = unstake_net_quantity.amount + unstake_cpu_quantity.amount;
    oretotal.symbol = unstake_net_quantity.symbol;

    action(
            permission_level{ from, "active"_n },
            "eosio.token"_n,
            "transfer"_n,
            make_tuple(from, pricetable.funder, oretotal, std::string("pay ore acc")))
            .send();

    action(
        permission_level{_self, "active"_n},
        "eosio"_n,
        name("undelegatebw"),
        make_tuple(_self, receiver, sys_unstake_net, sys_unstake_cpu))
        .send();
} // undelegatebw

ACTION systemore::buyram(name payer, name receiver, asset quant)
{
    require_auth(payer);

    asset sysamount;
    sysamount.amount = quant.amount;
    sysamount.symbol = symbol("SYS", 4);

    action(
            permission_level{ payer, "active"_n },
            "eosio.token"_n,
            "transfer"_n,
            make_tuple(payer, pricetable.funder, quant, std::string("pay ore acc")))
            .send();

    action(
        permission_level{_self, "active"_n},
        "eosio"_n,
        name("buyram"),
        make_tuple(_self, receiver, sysamount))
        .send();
}

ACTION systemore::buyrambytes(name payer, name receiver, uint32_t bytes)
{
    asset ram = common::getRamCost(bytes);
    asset oreamount;
    oreamount.symbol = symbol("ORE", 4);
    oreamount.amount = ram.amount;

    action(
            permission_level{ payer, "active"_n },
            "eosio.token"_n,
            "transfer"_n,
            make_tuple(payer, pricetable.funder, oreamount, std::string("pay ore acc")))
            .send();

    action(
        permission_level{_self, "active"_n},
        "eosio"_n,
        name("buyrambytes"),
        make_tuple(_self, receiver, bytes))
        .send();
}

ACTION systemore::sellram(name account, int64_t bytes)
{
    require_auth(account);

    action(
        permission_level{account, "active"_n},
        "eosio"_n,
        name("sellram"),
        make_tuple(account, bytes))
        .send();
}

EOSIO_DISPATCH(systemore, (setprice)(createoreacc)(delegatebw)(undelegatebw)(buyram)(buyrambytes)(sellram))