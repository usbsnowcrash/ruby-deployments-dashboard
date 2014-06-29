RAILS_ENV=production bundle exec rake assets:precompile
git aws.push
rm -rf public/assets/
RAILS_ENV=

