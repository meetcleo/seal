#!/bin/bash

teams=(
  core
  growth
  plus
)

for team in ${teams[*]}; do
  ./bin/seal.rb $team
done
