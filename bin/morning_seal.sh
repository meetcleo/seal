#!/bin/bash

teams=(
  lending
)

for team in ${teams[*]}; do
  ./bin/seal.rb $team
done
