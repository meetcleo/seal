#!/bin/bash

teams=(
  gringotts
  odyssey
  security_alerts
  data
)

for team in ${teams[*]}; do
  ./bin/seal.rb $team
done
