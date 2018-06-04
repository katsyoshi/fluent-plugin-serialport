require 'bundler/setup'
require 'simplecov'
SimpleCov.start

require 'test/unit'
require 'test/unit/rr'

$LOAD_PATH.unshift(File.join(__dir__, '..', 'lib'))
$LOAD_PATH.unshift(__dir__)
require 'fluent/test'
require 'fluent/test/driver/input'

require 'fluent/plugin/in_serialport'
