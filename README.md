ruby-deployments-dashboard
=========
[![Code Climate](https://codeclimate.com/github/usbsnowcrash/ruby-deployments-dashboard/badges/gpa.svg)](https://codeclimate.com/github/usbsnowcrash/ruby-deployments-dashboard)
[![Test Coverage](https://codeclimate.com/github/usbsnowcrash/ruby-deployments-dashboard/badges/coverage.svg)](https://codeclimate.com/github/usbsnowcrash/ruby-deployments-dashboard/coverage)
[![Build Status](https://travis-ci.org/usbsnowcrash/ruby-deployments-dashboard.svg)](https://travis-ci.org/usbsnowcrash/ruby-deployments-dashboard)

This is a simple dashboard to see what has been rolled into your production environment.
To see a specific repo http://localhost:3000/deployments/username/name-of-github-repo

To run locally

Some settings are set by env variables.
To simulate these in dev create a file named .env and place it in the root alongside the Gem File
######.env
``` sh
CLIENT_ID=<github client id goes here>
CLIENT_SECRET=<github client secret goes here>
```
