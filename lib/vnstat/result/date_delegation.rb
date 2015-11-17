module Vnstat
  class Result
    ##
    # A module that is included by result types that contain date information.
    module DateDelegation
      ##
      # The year the result was captured in.
      #
      # @return [Integer]
      def year
        date.year
      end

      ##
      # The month the result was captured in.
      #
      # @return [Integer]
      def month
        date.month
      end

      ##
      # The day the result was captured on.
      #
      # @return [Integer]
      def day
        date.day
      end
    end
  end
end
