require 'unicorn'
require 'rack/handler/unicorn'
require 'lograge'
require 'rails_serve_static_assets'
require 'newrelic_rpm'
require 'rollbar'

require 'rbsavvy/logger'

module RBSavvy
  def self.logger
    @@logger ||= ActiveSupport::TaggedLogging.new(RBSavvy::Logger.new)
  end
end

require 'rbsavvy/engine'