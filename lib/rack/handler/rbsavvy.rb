require_relative './unicorn'
require_relative './puma'


module Rack
  module Handler
    def self.default(options = {})
      pick ['puma', 'unicorn']
    end
  end
end