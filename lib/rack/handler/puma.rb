require 'rack/handler'
require 'puma'
require 'puma/cli'

class Puma::Events
  FORMATTER = DefaultFormatter.new
  def formatter
    FORMATTER
  end
end

module Rack
  module Handler
    module Puma
      def self.run(app, options = {})
        args = %W(-C #{packaged_config})

        events = ::Puma::Events.new(RBSavvy.logger, RBSavvy.logger)

        ::Puma::CLI.new(args, events).run
      end

      def self.packaged_config
        ::File.expand_path("../../../config/puma.rb", __FILE__ )
      end
    end

    register :puma, Puma
  end
end