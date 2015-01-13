require 'lhm/throttler/time'

module Lhm
  module Throttler
    CLASSES = { :time_throttler => Throttler::Time }

    def throttler
      @throttler ||= Throttler::Time.new
    end

    def setup_throttler(type, options = {})
      @throttler = Factory.create_throttler(type, options)
    end

    class Factory
      def self.create_throttler(type, options = {})
        case type
        when Lhm::Command
          type
        when Symbol
          CLASSES[type].new(options)
        when String
          CLASSES[type.to_sym].new(options)
        when Class
          type.new(options)
        else
          fail ArgumentError, 'type argument must be a Symbol, String or Class'
        end
      end
    end
  end
end
