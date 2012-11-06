$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'taskmapper'
require 'taskmapper-trac'
require 'rspec'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter = 'documentation'
end

