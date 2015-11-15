module Vnstat
  class Result
    module TimeComparable
      def <=>(other)
        return nil unless other.respond_to?(:bytes_transmitted)
        return nil unless other.respond_to?(:time)
        [time, bytes_transmitted] <=> [other.time, other.bytes_transmitted]
      end
    end
  end
end
