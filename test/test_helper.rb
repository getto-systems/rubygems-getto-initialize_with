$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "simplecov"
SimpleCov.start

require "getto/initialize_with"

require "minitest/autorun"
