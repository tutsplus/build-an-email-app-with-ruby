ENV['APP_ENV'] = 'test'

require 'bundler'
Bundler.require

require 'qrier/environment'
Bundler.require Qrier.environment

require 'qrier/config'
Qrier::Config.load

require "helpers"

Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new
