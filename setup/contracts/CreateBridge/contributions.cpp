#include <eosiolib/eosio.hpp>
#include <eosiolib/print.hpp>
#include <eosiolib/action.hpp>
#include <eosiolib/transaction.hpp>
#include <eosiolib/crypto.h>
#include <algorithm> 
#include <cstdlib>

#include "lib/common.h"

#include "models/accounts.h"
#include "models/balances.h"
#include "models/registry.h"
    
using namespace eosio;
using namespace std;
class contributions {

public:

    name createbridge = common::createbridge;

    /*
     * Returns the total balance contributed for a dapp
     */
    asset balanceFor(string& memo){
        balances::Balances balances(createbridge, createbridge.value);
        uint64_t payerId = common::toUUID(memo);
        auto payer = balances.find(payerId);
        if(payer == balances.end()) return asset(0'0000, common::getCoreSymbol());
        return payer->balance;
    }

    /*
     * Checks whether the balance for an account is greater than the required balance
     */
    bool hasBalance(string memo, const asset& quantity){
        return balanceFor(memo).amount > quantity.amount;
    }

    /*
     * Adds the amount contributed by the contributor for an app to the balances table
     * Called by the internal transfer function 
     */
    void addBalance(const name& from, const asset& quantity, string& memo){
        name account = name("");
        public_key ownerkey;
        public_key activekey;

        vector<string> stats = common::split(memo, ",");
        string origin = stats[0];
        uint64_t id = common::toUUID(origin);

        int ram = origin == "free" ? 100 : stoi(stats[1]);
        int totalaccounts = stats.size() == 3 ? stoi(stats[2]) : -1;

        if(stats.size() > 4){
            account = name(stats[3]);
            ownerkey = getPublicKey(stats[4]);
            activekey = getPublicKey(stats[5]);
        }

        balances::Balances balances(createbridge, createbridge.value);
        auto iterator = balances.find(id);
        if(iterator == balances.end()) balances.emplace(createbridge, [&](auto& row){
            row.memo = id;
            row.contributors.push_back({from, quantity, ram, totalaccounts, 0});
            row.balance = quantity;
            row.origin = origin;
            row.timestamp = now();

        });
        else balances.modify(iterator, same_payer, [&](auto& row){
            auto pred = [from](const balances::contributors & item) {
                return item.contributor == from;
            };
            std::vector<balances::contributors>::iterator itr = std::find_if(std::begin(row.contributors), std::end(row.contributors), pred);    
            if(itr != std::end(row.contributors)){
                itr->balance += quantity;
                itr->ram = ram;
                itr->totalaccounts = totalaccounts;
            } else {
                row.contributors.push_back({from, quantity, ram, totalaccounts, 0});
                row.timestamp = now();
            }
            row.balance += quantity;
        });

        if(account!=name("")){
            eosio_assert( !is_account( account ), "account already exists");

            action(
                permission_level{ from, "active"_n },
                name("createbridge"),
                name("create"),
                make_tuple(from.to_string(), account, ownerkey, activekey, origin)
            ).send();

            transaction reclaim_remaining_balance;

            // create a deferred transaction to transfer back the remaining balance to the "from" account
            reclaim_remaining_balance.actions.emplace_back(
                permission_level{ from, "active"_n },
                name("createbridge"),
                name("reclaim"),
                make_tuple(from, origin, common::getCoreSymbol().code().to_string())
            );
            reclaim_remaining_balance.delay_sec = 10;
            reclaim_remaining_balance.send(now(), name("createbridge"));
        }
    }

    /*
     * Subtracts the amount used to create an account from the total amount contributed by a contributor for an app
     * Also checks if the memo account is same as one of the dapp contributors. If yes, then only increases the createdaccount field by 1
     * Called by the create action
     */
    void subBalance(string memo, string& origin, const asset& quantity, bool memoIsDapp = false){
        uint64_t id = common::toUUID(origin);

        balances::Balances balances(createbridge, createbridge.value);
        auto iterator = balances.find(id);

        eosio_assert(iterator != balances.end(), "No balance object");
        eosio_assert(iterator->balance.amount >= quantity.amount, "overdrawn balance" );

        if(iterator->balance.amount - quantity.amount <= 0){
            balances.erase(iterator);
        }

        else balances.modify(iterator, same_payer, [&](auto& row){
            auto pred = [memo](const balances::contributors & item) {
                return item.contributor == name(memo);
            };
            auto itr = std::find_if(std::begin(row.contributors), std::end(row.contributors), pred);    
            if(itr != std::end(row.contributors)){
                row.balance -= quantity;
                itr->balance -= quantity;
                if(!memoIsDapp){
                    itr->createdaccounts += 1;
                }
            } else {
                eosio_assert(false, ("The account " + memo + "not found as one of the contributors for " + origin).c_str());
            }
        });
    }

    /**********************************************/
    /***                                        ***/
    /***               Helpers                  ***/
    /***                                        ***/
    /**********************************************/

    /***
     * Gets the balance of a contributor for a dapp
     * @return
     */
    asset findContribution(string dapp, name contributor){
        balances::Balances balances(createbridge, createbridge.value);
        uint64_t id = common::toUUID(dapp);
        auto iterator = balances.find(id);

        symbol coreSymbol = common::getCoreSymbol();

        auto msg = "No contribution found for " + dapp + " by " + contributor.to_string() + ".";

        // if no record found for the dapp in the balances table, return the balance for the contributor as 0
        if(iterator != balances.end()){
            auto pred = [contributor](const balances::contributors & item) {
                    return item.contributor == contributor;
            };
            auto itr = std::find_if(std::begin(iterator->contributors), std::end(iterator->contributors), pred);  
            if(itr != std::end(iterator->contributors)){
                return itr->balance;
            } else{
                print(msg.c_str());
                return asset(0'0000, coreSymbol);
            }
        } else {
            print(msg.c_str());
            return asset(0'0000, coreSymbol);
        }
    }

    /***
     * Gets the RAM contribution of a contributor for a dapp
     * @return
     */
    int findRamContribution(string dapp, name contributor){
        balances::Balances balances(createbridge, createbridge.value);
        uint64_t id = common::toUUID(dapp);
        auto iterator = balances.find(id);

        symbol coreSymbol = common::getCoreSymbol();

        auto msg = "No contribution found for " + dapp + " by " + contributor.to_string() + ". Checking the globally available free fund.";

        // if no record found for the dapp in the balances table, return the balance for the contributor as 0
        if(iterator != balances.end()){
            auto pred = [contributor](const balances::contributors & item) {
                    return item.contributor == contributor;
            };
            auto itr = std::find_if(std::begin(iterator->contributors), std::end(iterator->contributors), pred);  
            if(itr != std::end(iterator->contributors)){
                return itr->ram;
            } else{
                print(msg.c_str());
                return 0;
            }
        } else {
            print(msg.c_str());
            return 0;
        }
    }

    /**
     * Randomly select the contributors for a dapp
     * It has following steps:
     * 1. Generate a random number with the new account name as the seed and the payer account name as the value
     * 2. Mod the individual digits in the number by the contributors vector size to get all the indices within the vector size
     * 3. Remove the duplicate indices 
     * 4. Chooses the contributors which have created accounts < total accounts until the max contribution upto 100% is reached
     */
    vector<balances::chosen_contributors> getContributors(string origin, string memo, uint64_t seed, uint64_t to, asset ram){
        balances::Balances balances(createbridge, createbridge.value);
        auto iterator = balances.find(common::toUUID(origin));

        vector<balances::contributors> initial_contributors = iterator->contributors; 
        vector<balances::contributors> final_contributors;
        vector<balances::chosen_contributors> chosen_contributors;
        vector<int> chosen_index;

        // generate a random number with new account name as the seed
        uint64_t number = common::generate_random(seed, to);
        
        int size = initial_contributors.size();

        // get the index from the contributors corresponding to individual digits of the random number generated in the above step
        while(size > 0 && number > 0){
            int digit = number % 10;

            // modulus the digit of the random number by the initial_contributors to get the randomly generated indices within the size of the vector
            int index = digit % initial_contributors.size();
            
            // make sure not the same contributor is chosen twice
            if(std::find(chosen_index.begin(), chosen_index.end(), index) == chosen_index.end()){
                chosen_index.push_back(index);
                final_contributors.push_back(initial_contributors[index]);
            }
            number /= 10;
            size--;
        }

        int final_size = final_contributors.size();
        int i = 0;

        int max_ram_contribution = 100;
        int total_ram_contribution = 0;

        // choose the contributors to get the total contributions for RAM as close to 100% as possible
        while(total_ram_contribution < max_ram_contribution && i < final_size){
            //check if the total account creation limit has been reached for a contributor
            if((final_contributors[i].createdaccounts < final_contributors[i].totalaccounts || final_contributors[i].totalaccounts == -1) && final_contributors[i].contributor != name(memo)){

                int ram_contribution = findRamContribution(origin, final_contributors[i].contributor);
                total_ram_contribution += ram_contribution;
            
                if(total_ram_contribution > max_ram_contribution){
                    ram_contribution -= (total_ram_contribution - max_ram_contribution);
                }
                
                asset ram_amount = (ram_contribution * ram)/100;

                chosen_contributors.push_back(
                {
                    final_contributors[i].contributor,
                    ram_amount
                });
            }
            i++;
        }
        return chosen_contributors;

    }
};