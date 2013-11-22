Vagrant Builds for Twine
========================

## Changing to prod environment:
- cd /var/www/siv-v3/
- grunt prod

## Reset environment (back to dev):
- go to host system
- cd to the your siv-v3 repo
- git reset --hard && git clean -f

## Notes:
- "grunt prod" only works on a clean repo as strings are replaced in various files
- to reset to a clean repo, run "git reset --hard && git clean -f" on the host system
