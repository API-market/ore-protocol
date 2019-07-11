#include "ore.system.hpp"


// Setting newaccount parameters and the price in terms of ORE
// IMPORTANT: since bwpricerate is uint, ORE price needs to be equal or more than required SYS
ACTION oresystem::setprice(asset createprice, uint64_t rambytes, asset netamount, asset cpuamount, uint64_t pricekey)
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
        });
    }
    else
    {
        _prices.modify(priceitr, _self, [&](auto &p) {
            p.createprice = createprice;
            p.rambytes = rambytes;
            p.netamount = netamount;
            p.cpuamount = cpuamount;
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

    tierinfotable _tiers(_self, newname.value);
    _tiers.emplace(_self, [&](auto &t) {
        t.pricekey = pricekey;
        t.createprice = priceitr->createprice;
    });

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
    sys_stake_net.amount = priceitr->netamount.amount;
    sys_stake_cpu.amount = priceitr->cpuamount.amount;
    sys_stake_net.symbol = sys_symbol;
    sys_stake_cpu.symbol = sys_symbol;

    asset syslock;

    syslock.symbol = sys_symbol;
    syslock.amount = priceitr->createprice.amount - (sys_stake_net.amount + sys_stake_cpu.amount + ramprice.amount);

    action(
        permission_level{creator, "active"_n},
        "eosio.token"_n,
        "transfer"_n,
        make_tuple(creator, ore_lock, priceitr->createprice, std::string("ore lock")))
        .send();

    action(
        permission_level{ore_system, "active"_n},
        "eosio.token"_n,
        "transfer"_n,
        make_tuple(sys_payer, sys_lock, syslock, std::string("ore savings")))
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
// namespace oresystem

EOSIO_DISPATCH(oresystem, (setprice)(createoreacc))