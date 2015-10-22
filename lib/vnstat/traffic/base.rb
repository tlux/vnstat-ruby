module Vnstat
  module Traffic
    class Base
      include Enumerable

      attr_reader :interface

      def initialize(interface)
        @interface = interface
      end
    end
  end
end
