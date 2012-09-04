require 'fileutils'
require 'aruba/cucumber'
PROJECT_ROOT = "#{File.dirname(__FILE__)}/../.."
CUKE_TMP_DIR = File.join PROJECT_ROOT, 'features', 'tmp'

Before do
  @dirs = [CUKE_TMP_DIR]
end

Before do |scenario|
  FileUtils.rm_rf CUKE_TMP_DIR if Dir.exists? CUKE_TMP_DIR
end

After do |scenario|
  FileUtils.rm_rf CUKE_TMP_DIR if Dir.exists? CUKE_TMP_DIR
end
