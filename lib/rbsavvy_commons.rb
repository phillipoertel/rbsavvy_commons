module RBSavvy
  def self.logger
    @@logger ||= ActiveSupport::TaggedLogging.new(RBSavvy::Logger.new)
  end

  def self.file_path(rel_path)
    path = File.expand_path("../#{rel_path}", __FILE__)
    path if File.exists?(path)
  end
end

# Dotenv
require 'dotenv'
Dotenv.load if Rails.env.test? or Rails.env.development?

# New Relic
ENV['NRCONFIG'] ||= RBSavvy.file_path("config/newrelic.yml")
require 'newrelic_rpm'

# Unicorn
require 'unicorn'
require 'rack/handler/unicorn'

# Random
require 'lograge'
require 'rails_serve_static_assets'
require 'rollbar'

# rbsavvy specific
require 'rbsavvy/logger'
require 'rbsavvy/railtie'
