#!/bin/bash

teams=(
  seal_team
)

for team in ${teams[*]} ; do
  ./bin/seal_runner.rb $team quotes
done
