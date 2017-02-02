#!/usr/bin/env bash

coffee_files="app/assets/javascripts"

ruby_files=`find -L {app,lib,features,spec,config} | grep -e '\.rb$' | grep -v 'lib/tasks/database_helper' | xargs`
app_files=`find -L {app,lib,config} | grep -e '\.rb$'| grep -v 'lib/tasks/database_helper' | grep -v 'lib/active_admin' | grep -v 'config/routes.rb' | xargs`

echo -e "\n\n\nRails security check results\n"
bundle exec warder --bundle-audit
rails_security_exit_code=$?

echo -e "\n\n\nMagic numbers results\n"
bundle exec warder --stats --magick-numbers $app_files
magick_numbers_exit_code=$?

echo -e "\n\n\nCode duplication results\n"
bundle exec warder --stats --code-duplication $app_files
code_duplication_exit_code=$?

echo -e "\n\n\nCode complexity results\n"
bundle exec warder --stats --code-complexity $app_files
code_complexity_exit_code=$?

echo -e "\n\n\nCode smell detector result\n"
bundle exec warder --stats --code-smell $app_files
code_smell_exit_code=$?

echo -e "\n\n\nCode style guide compliance results\n"
bundle exec warder --stats --style-guide $ruby_files
ruby_style_guide_exit_code=$?

bundle exec warder --stats --coffee-lint $coffee_files
coffee_style_guide_exit_code=$?

exit $(($rails_security_exit_code+$magick_numbers_exit_code+$code_complexity_exit_code+$ruby_style_guide_exit_code+$coffee_style_guide_exit_code+$code_duplication_exit_code+$code_smell_exit_code));

