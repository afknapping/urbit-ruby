require_relative 'urbit/config'
require_relative 'urbit/ship'

# This is the main namespace for Urbit.
#
# It provides a method to create {Urbit::Ship} objects.
#
# @example Helpful class method `.new` to create {Urbit::Ship} objects.
#   ship = Urbit.new(port: 80)
#   conn.get '/'
module Urbit
  class << self
    def new(**config_options)
      config = Urbit::Config.merge(config_options)
      Urbit::Ship.new(config: config)
    end
  end
end
