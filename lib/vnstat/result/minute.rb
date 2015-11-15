module Vnstat
  class Result
    class Minute < Result
      include DateDelegation
      include TimeComparable

      attr_reader :time

      def initialize(time, bytes_received, bytes_sent)
        @time = time
        super(bytes_received, bytes_sent)
      end

      def self.extract_from_xml_element(element)
        new(
          Parser.extract_datetime_from_xml_element(element),
          *Parser.extract_transmitted_bytes_from_xml_element(element)
        )
      end

      def date
        time.to_date
      end

      def hour
        time.hour
      end

      def minute
        time.minute
      end
    end
  end
end
