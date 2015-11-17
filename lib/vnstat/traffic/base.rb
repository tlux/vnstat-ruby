module Vnstat
  module Traffic
    class Base
      include Enumerable

      attr_reader :interface

      ##
      # Initializes the traffic collection.
      #
      # @param [Interface] interface The tracked interface.
      def initialize(interface)
        @interface = interface
      end

      ##
      # Iterates over all results in the collection.
      #
      # @yield [result]
      # @yieldparam [Result] result
      def each(&block)
        entries_hash.values.each(&block)
      end

      private

      def traffic_data
        interface.data.xpath('//traffic')
      end

      def entries_hash
        fail NotImplementedError,
             "Please override #{self.class.name}##{__method__}"
      end
    end
  end
end
