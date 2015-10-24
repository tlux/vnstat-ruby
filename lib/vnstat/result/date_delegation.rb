module Vnstat
  class Result
    module DateDelegation
      def year
        date.year
      end

      def month
        date.month
      end

      def day
        date.day
      end
    end
  end
end
