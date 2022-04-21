#!/bin/bash

teams=(
  gringotts
  odyssey
  security_alerts
)

for team in ${teams[*]}; do
  ./bin/seal.rb $team
done
