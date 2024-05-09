#!/bin/bash

teams=(
  github_bots
  payments_infrastructure
  data
  cash_advance
  seal_team
  security_alerts
  card_2
  plus
)

for team in ${teams[*]}; do
  ./bin/seal.rb $team
done

morning_quote_teams=()

for team in ${morning_quote_teams[*]}; do
  ./bin/seal.rb $team quotes
done
