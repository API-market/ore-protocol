#!/bin/bash
cleos=$1

$cleos wallet unlock -n local --password PW5KaVyD3RTq5QER4zHLNXoCxJZLCgMWmvpAiXdwwBvKFp5F1g2TL

$cleos system voteproducer prods producer1 producer1
$cleos system voteproducer prods producer2 producer1
$cleos system voteproducer prods producer3 producer1