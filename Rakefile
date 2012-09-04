require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '--color'
  t.pattern = 'spec/**/*_spec.rb'
end

require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:cucumber) do |t|
  t.cucumber_opts = "--format pretty --expand --color"
  t.fork = false
end

task :default  => [:spec, :cucumber]
