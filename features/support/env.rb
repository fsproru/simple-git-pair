require 'fileutils'
require 'aruba/cucumber'
PROJECT_ROOT = "#{File.dirname(__FILE__)}/../.."
CUKE_TMP_DIR = File.join PROJECT_ROOT, 'features', 'tmp'

Before do
  @dirs = [CUKE_TMP_DIR]
  @real_home = ENV['HOME']
  ENV['HOME'] = CUKE_TMP_DIR
  @pairs_file = File.join ENV['HOME'], ".git_pairs"
  FileUtils.rm_rf CUKE_TMP_DIR if File.exists? CUKE_TMP_DIR
end

After do |scenario|
  FileUtils.rm_rf CUKE_TMP_DIR if File.exists? CUKE_TMP_DIR
  ENV['HOME'] = @real_home
end
