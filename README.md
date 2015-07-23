ruby-deployments-dashboard
=========
This is a simple dashboard to see what has been rolled into your production envrionment.
To see a specific repo http://localhost:3000/deployments/name-of-github-repo 

To run locally

Some settings are set by env variables.
To simulate these in dev create a file named .env and place it in the root alongside the Gem File
######.env
``` sh
GITHUB_TOKEN=PUT_YOUR_OAUTH_TOKEN_HERE
