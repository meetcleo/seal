#!/bin/bash

teams=(
  core
  growth
  plus
  mobile-app
)

for team in ${teams[*]}; do
  ./bin/seal.rb $team
done
