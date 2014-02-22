Given /^there is a local repo$/ do
  @git_repo   = 'my-repo'
  step %Q{a directory named "#{@git_repo}"}
  step %Q{I cd to "#{@git_repo}"}
  step 'I run `git init`'
end

Given /^there is (no|a) pairs file$/ do |yes_no|
  file_should_exist = yes_no == "a" ? true : false

  if file_should_exist
    `git pair init`
  else
    step %Q{I remove the file "#{@pairs_file}"} if File.exists? @pairs_file
  end
end

Then /^it creates a sample pairs file$/ do
  step %Q{a file named "#{@pairs_file}" should exist}
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

When /^I wait (\d+) seconds$/ do |seconds|
  sleep seconds.to_i
end

Then /^I should see "(.*?)" on the commit$/ do |username|
  step 'I run `git --no-pager log`'
  step %Q{the output should contain "Author: #{username}"}
end

Then /^it should offer to create a sample config$/ do
  step %Q{the output should contain "Create a sample one?"}
end
