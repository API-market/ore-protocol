#include "ore.system.hpp"


// Setting newaccount parameters and the price in terms of ORE
// IMPORTANT: since bwpricerate is uint, ORE price needs to be equal or more than required SYS
ACTION oresystem::setprice(asset createprice, uint64_t rambytes, asset netamount, asset cpuamount, uint64_t bwpricerate, uint64_t pricekey)
{
    require_auth(_self);

    auto priceitr = _prices.find(pricekey);

    if (priceitr == _prices.end())
    {
        _prices.emplace(_self, [&](auto &p) {
            p.key = pricekey;
            p.createprice = createprice;
            p.rambytes = rambytes;
            p.netamount = netamount;
            p.cpuamount = cpuamount;
            p.bwpricerate = bwpricerate;
        });
    }
    else
    {
        _prices.modify(priceitr, _self, [&](auto &p) {
            p.createprice = createprice;
            p.rambytes = rambytes;
            p.netamount = netamount;
            p.cpuamount = cpuamount;
            p.bwpricerate = bwpricerate;
        });
    }
}

ACTION oresystem::createoreacc(name creator,
                               name newname,
                               public_key &ownerkey,
                               public_key &activekey,
                               uint64_t pricekey,
                               name referral
                               )
{

    authority ownerauth{.threshold = 1, .keys = {key_weight{ownerkey, 1}}, .accounts = {}, .waits = {}};
    authority activeauth{.threshold = 1, .keys = {key_weight{activekey, 1}}, .accounts = {}, .waits = {}};

    auto priceitr = _prices.find(pricekey);
    check(priceitr != _prices.end(), "No price table");
    referralstatstable _stats(_self, referral.value);
    auto statsitr = _stats.find(pricekey);
    
    if(statsitr != _stats.end()) {
        _stats.modify(statsitr, _self, [&](auto &s) {
            s.count += 1;
        });
    } else {
        _stats.emplace(_self, [&](auto &s) {
            s.pricekey = pricekey;
            s.count = 1;
        });
    }

    referrallogtable _log(_self, _self.value);
    _log.emplace(_self, [&](auto &l) {
        l.newaccount = newname;
        l.referral = referral;
    });

    //Get the ramprice and calculate the amount of SYS to be locked

    asset ramprice = common::getRamCost(priceitr->rambytes);
    asset sys_stake_net, sys_stake_cpu;
    sys_stake_net.amount = priceitr->netamount.amount / priceitr->bwpricerate;
    sys_stake_cpu.amount = priceitr->cpuamount.amount / priceitr->bwpricerate;
    sys_stake_net.symbol = sys_symbol;
    sys_stake_cpu.symbol = sys_symbol;

    asset locksys;
    locksys.symbol = sys_symbol;
    locksys.amount = priceitr->createprice.amount - (sys_stake_net.amount + sys_stake_cpu.amount + ramprice.amount);

    action(
        permission_level{creator, "active"_n},
        "eosio.token"_n,
        "transfer"_n,
        make_tuple(creator, ore_lock, priceitr->createprice, std::string("pay ore acc")))
        .send();

    action(
        permission_level{ore_system, "active"_n},
        "eosio.token"_n,
        "transfer"_n,
        make_tuple(sys_payer, sys_lock, locksys, std::string("lock sys")))
        .send();

    accounts::newaccount new_account = accounts::newaccount{
        .creator = creator,
        .name = newname,
        .owner = ownerauth,
        .active = activeauth};
    print("before newacc");

    action(
        permission_level{creator, "active"_n},
        "eosio"_n,
        "newaccount"_n,
        new_account)
        .send();

    action(
        permission_level{sys_payer, "active"_n},
        "eosio"_n,
        name("buyrambytes"),
        make_tuple(sys_payer, newname, priceitr->rambytes))
        .send();

    action(
        permission_level{sys_payer, "active"_n},
        "eosio"_n,
        name("delegatebw"),
        make_tuple(sys_payer, newname, sys_stake_net, sys_stake_cpu, false))
        .send();
}

ACTION oresystem::delegatebw(name from, name receiver,
                             asset stake_net_quantity,
                             asset stake_cpu_quantity)

{
    auto priceitr = _prices.find(name("ore").value);


    // Calculate required SYS to be delegated by using "bwpricerate"
    asset sys_stake_net, sys_stake_cpu;
    sys_stake_net.amount = stake_net_quantity.amount / priceitr->bwpricerate;
    sys_stake_cpu.amount = stake_cpu_quantity.amount / priceitr->bwpricerate;
    sys_stake_net.symbol = sys_symbol;
    sys_stake_cpu.symbol = sys_symbol;

    asset oretotal;
    oretotal.symbol = ore_symbol;
    oretotal.amount = stake_net_quantity.amount + stake_cpu_quantity.amount;

    // Calculate sys to be locked
    asset locksys;
    locksys.symbol = sys_symbol;
    locksys.amount = oretotal.amount - (sys_stake_net.amount + sys_stake_cpu.amount);

    action(
        permission_level{from, "active"_n},
        "eosio.token"_n,
        "transfer"_n,
        make_tuple(from, ore_lock, oretotal, std::string("pay ore acc")))
        .send();

    action(
        permission_level{from, "active"_n},
        "eosio.token"_n,
        "transfer"_n,
        make_tuple(sys_payer, sys_lock, locksys, std::string("lock sys")))
        .send();

    action(
        permission_level{_self, "active"_n},
        "eosio"_n,
        name("delegatebw"),
        make_tuple(sys_payer, receiver, sys_stake_net, sys_stake_cpu, true))
        .send();
}

ACTION oresystem::undelegatebw(name from, name receiver,
                               asset unstake_net_quantity,
                               asset unstake_cpu_quantity)
{

    auto priceitr = _prices.find(name("ore").value);

    asset sys_unstake_net, sys_unstake_cpu, oretotal;

    sys_unstake_net.amount = unstake_net_quantity.amount / priceitr->bwpricerate;
    sys_unstake_cpu.amount = unstake_cpu_quantity.amount / priceitr->bwpricerate;
    sys_unstake_net.symbol = sys_symbol;
    sys_unstake_cpu.symbol = sys_symbol;

    oretotal.amount = unstake_net_quantity.amount + unstake_cpu_quantity.amount;
    oretotal.symbol = unstake_net_quantity.symbol;

    asset sysunlock;
    sysunlock.symbol = sys_symbol;
    sysunlock.amount = oretotal.amount - (sys_unstake_net.amount + sys_unstake_cpu.amount);

    action(
        permission_level{from, "active"_n},
        "eosio.token"_n,
        "transfer"_n,
        make_tuple(ore_lock, receiver, oretotal, std::string("pay ore acc")))
        .send();

    action(
        permission_level{from, "active"_n},
        "eosio.token"_n,
        "transfer"_n,
        make_tuple(sys_lock, sys_payer, sysunlock, std::string("pay ore acc")))
        .send();

    action(
        permission_level{sys_payer, "active"_n},
        "eosio"_n,
        name("undelegatebw"),
        make_tuple(sys_payer, receiver, sys_unstake_net, sys_unstake_cpu))
        .send();
} // undelegatebw

ACTION oresystem::buyram(name payer, name receiver, asset quant)
{
    auto priceitr = _prices.find(name("ore").value);
    asset sysram;
    sysram.amount = quant.amount / priceitr->bwpricerate;
    sysram.symbol = sys_symbol;

    asset syslock;
    syslock.symbol = sys_symbol;
    syslock.amount = quant.amount - sysram.amount;

    action(
        permission_level{payer, "active"_n},
        "eosio.token"_n,
        "transfer"_n,
        make_tuple(payer, ore_lock, quant, std::string("pay ore acc")))
        .send();

    action(
        permission_level{sys_payer, "active"_n},
        "eosio.token"_n,
        "transfer"_n,
        make_tuple(sys_payer, sys_lock, syslock, std::string("pay ore acc")))
        .send();

    action(
        permission_level{sys_payer, "active"_n},
        "eosio"_n,
        name("buyram"),
        make_tuple(sys_payer, receiver, sysram))
        .send();
}

ACTION oresystem::buyrambytes(name payer, name receiver, uint32_t bytes)
{
    auto priceitr = _prices.find(name("ore").value);

    asset sysram = common::getRamCost(bytes);
    asset oreram;
    oreram.symbol = ore_symbol;
    oreram.amount = sysram.amount * priceitr->bwpricerate;

    asset syslock;
    syslock.symbol = sys_symbol;
    syslock.amount = oreram.amount - sysram.amount;

    action(
        permission_level{payer, "active"_n},
        "eosio.token"_n,
        "transfer"_n,
        make_tuple(payer, ore_lock, oreram, std::string("pay ore acc")))
        .send();

    action(
        permission_level{sys_payer, "active"_n},
        "eosio.token"_n,
        "transfer"_n,
        make_tuple(sys_payer, sys_lock, syslock, std::string("pay ore acc")))
        .send();

    action(
        permission_level{sys_payer, "active"_n},
        "eosio"_n,
        name("buyrambytes"),
        make_tuple(sys_payer, receiver, bytes))
        .send();
}


// More tests needed.
ACTION oresystem::sellram(name account, int64_t bytes)
{
    auto priceitr = _prices.find(name("ore").value);

    asset sysram = common::getRamCost(bytes);
    asset oreram;
    oreram.symbol = ore_symbol;
    oreram.amount = sysram.amount * priceitr->bwpricerate;

    asset sysunlock;
    sysunlock.symbol = sys_symbol;
    sysunlock.amount = oreram.amount - sysram.amount;


    action(
        permission_level{account, "active"_n},
        "eosio"_n,
        name("sellram"),
        make_tuple(account, bytes))
        .send();

    action(
        permission_level{account, "active"_n},
        "eosio.token"_n,
        "transfer"_n,
        make_tuple(account, sys_payer, sysram, std::string("pay ore acc")))
        .send();

    action(
        permission_level{sys_lock, "active"_n},
        "eosio.token"_n,
        "transfer"_n,
        make_tuple(sys_lock, sys_payer, sysunlock, std::string("pay ore acc")))
        .send();
    
    action(
        permission_level{sys_lock, "active"_n},
        "eosio.token"_n,
        "transfer"_n,
        make_tuple(ore_lock, account, oreram, std::string("pay ore acc")))
        .send();

}
// namespace oresystem

EOSIO_DISPATCH(oresystem, (setprice)(createoreacc)(delegatebw)(undelegatebw)(buyram)(buyrambytes)(sellram))