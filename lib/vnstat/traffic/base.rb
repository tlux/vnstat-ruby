module Vnstat
  module Traffic
    class Base
      include Enumerable

      attr_reader :interface

      def initialize(interface)
        @interface = interface
      end

      def each(&block)
        entries_hash.each_value(&block)
      end

      private

      def traffic_data
        interface.data.xpath('traffic')
      end

      def entries_hash
        fail NotImplementedError,
             "Please override #{self.class.name}#entries_hash"
      end
    end
  end
end
