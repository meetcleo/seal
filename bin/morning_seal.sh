#!/bin/bash

teams=(
  gringotts
  odyssey
  security_alerts
  data,
  lannisters
)

for team in ${teams[*]}; do
  ./bin/seal.rb $team
done
