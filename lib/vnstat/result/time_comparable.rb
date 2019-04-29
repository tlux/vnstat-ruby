# frozen_string_literal: true

module Vnstat
  class Result
    ##
    # A module that is included by result types that can be compared based
    # on their particular time information.
    module TimeComparable
      ##
      # @return [Integer, nil]
      def <=>(other)
        return nil unless other.respond_to?(:bytes_transmitted)
        return nil unless other.respond_to?(:time)

        [time, bytes_transmitted] <=> [other.time, other.bytes_transmitted]
      end
    end
  end
end
