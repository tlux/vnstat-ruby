# frozen_string_literal: true

module Vnstat
  module Traffic
    ##
    # An abstract implementation for a traffic collection.
    #
    # @attr_reader [Interface] interface The tracked interface.
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
      # @overload each
      #   @return [Enumerator]
      #
      # @overload each(&block)
      #   @yield [result]
      #   @yieldparam [Result] result
      #   @return [Base]
      def each(&block)
        entries_hash.values.each(&block)
      end

      private

      def traffic_data
        interface.data.xpath('//traffic')
      end
    end
  end
end
