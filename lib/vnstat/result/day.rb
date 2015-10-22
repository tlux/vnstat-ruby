module Vnstat
  module Result
    class Day < Base
      attr_reader :date
      
      def initialize(date, *args)
        @date = date
        super(*args)
      end
    end
  end
end
