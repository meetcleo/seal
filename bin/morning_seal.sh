#!/bin/bash

teams=(
  monet
  gringotts
)

for team in ${teams[*]}; do
  ./bin/seal.rb $team
done
