#!/bin/bash

teams=(
  gringotts
  odyssey
)

for team in ${teams[*]}; do
  ./bin/seal.rb $team
done
