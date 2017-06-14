#!/usr/bin/env bash

###############################################################################
# Ruby                                                                        #
###############################################################################

# rbenv *should* be installed at this point
hash rbenv 2>/dev/null || echo "Please install rbenv before continuing"

# Install latest (stable) Ruby
ruby_latest=$(rbenv install -l 2>/dev/null | awk '$1 ~ /^[0-9.]*$/ {latest=$1} END {print latest}')

versions=(
  2.3.1
  2.3.4
  $ruby_latest
)
for version in "${versions[@]}"
do
  if ! rbenv versions | grep $version
  then
    rbenv install $version
    rbenv global $version
    gem install bundler
  fi
done
