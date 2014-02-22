require File.expand_path("../lib/simple-git-pair/version", __FILE__)

Gem::Specification.new do |s|
  s.name         = "simple-git-pair"
  s.version      = SimpleGitPair::VERSION
  s.platform     = Gem::Platform::RUBY
  s.authors      = ["Alexander Tamoykin"]
  s.email        = ["a.tamoykin@gmail.com"]
  s.homepage     = "http://github.com/fsproru/simple-git-pair"
  s.summary      = SimpleGitPair::SUMMARY
  s.description  = SimpleGitPair::SUMMARY
  s.files        = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.require_path = 'lib'
  s.executables  = "git-pair"
  s.test_files   = Dir["spec/**/*.rb", "features/**/*.rb"]
  s.post_install_message = "Pair up! Run: git pair"

  s.add_runtime_dependency 'commander', '~> 4.1.6'
  s.add_runtime_dependency 'rainbow', '~> 2.0.0'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'aruba'
  s.add_development_dependency 'cucumber'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'debugger'
end
