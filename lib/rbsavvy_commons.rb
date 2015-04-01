require 'unicorn-rails'
require 'lograge'

require 'rbsavvy/logger'

module RBSavvy
  def self.logger
    @@logger ||= ActiveSupport::TaggedLogging.new(RBSavvy::Logger.new)
  end
end

require 'rbsavvy/engine'