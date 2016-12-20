# Harvest Reports

## Installation

To install, download this repository and run `bundle install`.

Create a `.env` file from `.env.dist` and supply your Harvest credentials

## Quick Start


```bash
# Download your Harvest data
./bin/harvest-reports download

# Run a monthly report

./bin/harvest-reports user-monthly-report 2016-01

# Run a monthly report, outputted to CSV

./bin/harvest-reports user-monthly-report --csv 2016-01

# Run a montly report, sorted by field, outputted to CSV

./bin/harvest-reports user-monthly-report --csv --sort="Rounded Billable Actualized" 2016-01
```

## Running Commands

Use `./bin/harvest-reports` to see the list of available commands.
