#!/bin/bash

teams=(
  money
  squad_x
)

for team in ${teams[*]}; do
  ./bin/seal.rb $team
done
