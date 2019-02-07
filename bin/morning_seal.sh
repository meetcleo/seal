#!/bin/bash

teams=(
  core
)

for team in ${teams[*]}; do
  ./bin/seal.rb $team
done
