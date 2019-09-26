#!/bin/bash

teams=(
  money
)

for team in ${teams[*]}; do
  ./bin/seal.rb $team
done
