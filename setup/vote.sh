#!/bin/bash

# cleos system voteproducer prods producer1 producer1 producer2 producer3
# cleos system voteproducer prods producer2 producer1 producer2 producer3
# cleos system voteproducer prods producer3 producer3 producer2 producer1

cleos system voteproducer prods producer1 producer1
cleos system voteproducer prods producer2 producer1
cleos system voteproducer prods producer3 producer1