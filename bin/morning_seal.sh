#!/bin/bash

teams=(
  core
  plus
)

for team in ${teams[*]}; do
  ./bin/seal.rb $team
done
