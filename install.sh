#!/bin/sh

# Install coffeescript
npm install coffee-script -g

# Install any normal dependencies
mkdir node_modules -p
npm install

# Get coffeejade
git clone https://github.com/fusesource/coffeejade node_modules/coffeejade

# Change the commander dependency so that it can be installed
sed "s/commander\": \"0.1/commander\": \"0.4/" node_modules/coffeejade/package.json > node_modules/coffeejade/package.json.bak
mv node_modules/coffeejade/package.json.bak node_modules/coffeejade/package.json

# Install coffeejade
cd node_modules/coffeejade
npm install

