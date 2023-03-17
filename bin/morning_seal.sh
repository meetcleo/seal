#!/bin/bash

teams=(
  payments_infrastructure
  odyssey
  security_alerts
  data
  payments_security_experience
)

for team in ${teams[*]}; do
  ./bin/seal.rb $team
done
