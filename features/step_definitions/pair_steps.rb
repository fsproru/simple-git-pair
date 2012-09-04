GIT_REPO   = 'my-repo'
# PAIRS_FILE = '.git_pairs'
PAIRS_FILE = File.expand_path '~/.git_pairs'

Given /^there is a local repo$/ do
  step %Q{a directory named "#{GIT_REPO}"}
  step %Q{I cd to "#{GIT_REPO}"}
  step 'I run `git init`'
end

Given /^there is no pairs file$/ do
  # TODO: use pairs file in features/tmp for testing
  # pairs_file = File.join CUKE_TMP_DIR, GIT_REPO, PAIRS_FILE
  step %Q{I remove the file "#{PAIRS_FILE}"} if File.exists? PAIRS_FILE
end

Then /^it creates a sample pairs file$/ do
  step %Q{a file named "#{PAIRS_FILE}" should exist}
end

When /^the git username should be "(.*?)"$/ do |username|
  step "I run `git config user.name`"
  step %Q{the output should contain "#{username}"}
end

When /^I commit some changes$/ do
  step 'I append to "some_file" with "some_changes"'
  step 'I run `git add .`'
  step 'I run `git commit -m "some changes"`'
end

Then /^I should see "(.*?)" on the commit$/ do |username|
  step 'I run `git --no-pager log`'
  step %Q{the output should contain "(#{username}) some changes"}
end
