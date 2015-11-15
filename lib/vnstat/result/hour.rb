module Vnstat
  class Result
    class Hour < Result
      include DateDelegation
      include TimeComparable

      attr_reader :date, :hour

      def initialize(date, hour, bytes_received, bytes_sent)
        @date = date
        @hour = hour
        super(bytes_received, bytes_sent)
      end

      def self.extract_from_xml_element(element)
        date = Parser.extract_date_from_xml_element(element)
        hour = Integer(element.attr('id').to_s)
        new(date, hour, *Parser.extract_transmitted_bytes_from_xml_element(element))
      end

      def <=>(other)
        return nil unless other.respond_to?(:bytes_transmitted)
        return nil unless other.respond_to?(:time)
        [time, bytes_transmitted] <=> [other.time, other.bytes_transmitted]
      end

      def time
        DateTime.new(year, month, day, hour)
      end
    end
  end
end
