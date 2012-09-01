require File.expand_path("../lib/simple-git-pair/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "simple-git-pair"
  s.version     = SimpleGitPair::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Alexander Tamoykin"]
  s.email       = ["a.tamoykin@gmail.com"]
  s.homepage    = "http://github.com/fsproru/simple-git-pair"
  s.summary     = "Adds your pair to a commit message"
  s.description = "Changes only user.name setting in git config, \
                   so github can still understand under which account a code was committed"
  s.files        = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.require_path = 'lib'
  s.executables  = "git-pair"
  s.test_files   = Dir["spec/**/*.rb"]

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'debugger'
end
