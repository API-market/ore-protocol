#include "ore.system.hpp"

ACTION oresystem::setprice(name funder, asset newaccprice)
{
    require_auth(_self);

    oresystem::funder = funder;
    oresystem::createprice = newaccprice;
}

ACTION oresystem::createoreacc(name creator,
                               name newname,
                               public_key& ownerkey,
                               public_key& activekey,
                               asset ramquant,
                               asset stake_net_quantity,
                               asset stake_cpu_quantity)
{




    // INLINE_ACTION_SENDER(eosio::token, transfer)
    // (
    //     "eosio.token"_n, {{creator, active_permission}},
    //     {creator, itr->funder, itr->newaccprice, std::string("pay ore acc")});

    name oresystem = common::oresystem;

    authority ownerauth{ .threshold = 1, .keys = {key_weight{ownerkey, 1}}, .accounts = {}, .waits = {} };
    authority activeauth{ .threshold = 1, .keys = {key_weight{activekey, 1}}, .accounts = {}, .waits = {} };

    asset createprice;

    createprice.symbol = symbol(symbol_code("ORE"), 4);
    createprice.amount = 10000;

    print("before transfer");
    action(
            permission_level{ creator, "active"_n },
            "eosio.token"_n,
            "transfer"_n,
            make_tuple(creator, oresystem, createprice , std::string("pay ore acc")))
            .send();

    accounts::newaccount new_account = accounts::newaccount{
            .creator = creator,
            .name = newname,
            .owner = ownerauth,
            .active = activeauth
    };
    print("before newacc");

    action(
            permission_level{ creator, "active"_n },
            "eosio"_n,
            "newaccount"_n,
            new_account
        ).send();

    buyram(creator, newname, ramquant);

    delegatebw(creator, newname, stake_net_quantity, stake_cpu_quantity);

    // INLINE_ACTION_SENDER(eosiosystem::system_contract, buyram)
    //     (
    //         "eosio"_n, {{_self, active_permission}},
    //         {_self, newact, ramquant});

    // INLINE_ACTION_SENDER(eosiosystem::system_contract, delegatebw)
    // (
    //     "eosio"_n, {{_self, active_permission}},
    //     {_self, newact, stake_net_quantity, stake_cpu_quantity, true});
}

ACTION oresystem::delegatebw(name from, name receiver,
                             asset stake_net_quantity,
                             asset stake_cpu_quantity)

{
    //changebw(from, receiver, stake_net_quantity, stake_cpu_quantity, transfer);
    asset sys_stake_net, sys_stake_cpu;
    sys_stake_net.amount = stake_net_quantity.amount;
    sys_stake_cpu.amount = stake_cpu_quantity.amount;
    sys_stake_net.symbol = symbol("SYS", 4);
    sys_stake_cpu.symbol = symbol("SYS", 4);
    action(
        permission_level{_self, "active"_n},
        "eosio"_n,
        name("delegatebw"),
        make_tuple(_self, receiver, sys_stake_net, sys_stake_cpu, true))
        .send();
} // delegatebw

ACTION oresystem::undelegatebw(name from, name receiver,
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
            make_tuple(from, "oresystem_n", oretotal, std::string("pay ore acc")))
            .send();

    action(
        permission_level{_self, "active"_n},
        "eosio"_n,
        name("undelegatebw"),
        make_tuple(_self, receiver, sys_unstake_net, sys_unstake_cpu))
        .send();
} // undelegatebw

ACTION oresystem::buyram(name payer, name receiver, asset quant)
{
    asset sysamount;
    sysamount.amount = quant.amount;
    sysamount.symbol = symbol("SYS", 4);

    action(
            permission_level{ payer, "active"_n },
            "eosio.token"_n,
            "transfer"_n,
            make_tuple(payer, "oresystem"_n, quant, std::string("pay ore acc")))
            .send();

    action(
        permission_level{_self, "active"_n},
        "eosio"_n,
        name("buyram"),
        make_tuple(_self, receiver, sysamount))
        .send();
}

ACTION oresystem::buyrambytes(name payer, name receiver, uint32_t bytes)
{
    asset ram = common::getRamCost(bytes);
    asset oreamount;
    oreamount.symbol = symbol("ORE", 4);
    oreamount.amount = ram.amount;

    action(
            permission_level{ payer, "active"_n },
            "eosio.token"_n,
            "transfer"_n,
            make_tuple(payer, "oresystem"_n, oreamount, std::string("pay ore acc")))
            .send();

    action(
        permission_level{_self, "active"_n},
        "eosio"_n,
        name("buyrambytes"),
        make_tuple(_self, receiver, bytes))
        .send();
}

ACTION oresystem::sellram(name account, int64_t bytes)
{
    action(
        permission_level{account, "active"_n},
        "eosio"_n,
        name("sellram"),
        make_tuple(account, bytes))
        .send();
}

EOSIO_DISPATCH(oresystem, (setprice)(createoreacc)(delegatebw)(undelegatebw)(buyram)(buyrambytes)(sellram))