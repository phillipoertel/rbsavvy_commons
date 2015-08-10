require_relative './unicorn'
require_relative './puma'


module Rack
  module Handler
    def self.default(options = {})
      pick ['unicorn', 'puma']
    end
  end
end