#!/bin/bash

teams=(
  seal_team
)

for team in ${teams[*]}; do
  ./bin/seal_runner.rb $team
done

morning_quote_teams=(
  fun-workstream-govuk
  fun-workstream-gds-community
  govuk-green-team
  navigation-and-homepage-govuk
  dev-platform-team
)

for team in ${morning_quote_teams[*]}; do
  ./bin/seal_runner.rb $team quotes
done
