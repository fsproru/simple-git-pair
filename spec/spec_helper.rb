$:.unshift(File.dirname(__FILE__) + '/../lib')

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

Rspec.configure do |config|
  config.color_enabled = true
end
