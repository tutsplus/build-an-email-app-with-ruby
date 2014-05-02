ENV['APP_ENV'] = 'test'

require 'bundler'
Bundler.require

require 'qrier/environment'
Bundler.require Qrier.environment

require "helpers"

Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new
