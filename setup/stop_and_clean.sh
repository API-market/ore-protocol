#!/bin/bash

cd genesis
./stop.sh
./clean.sh

cd ../producer1
./stop.sh
./clean.sh

cd ../producer2
./stop.sh
./clean.sh

cd ../producer3
./stop.sh
./clean.sh