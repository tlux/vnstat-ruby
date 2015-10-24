module Vnstat
  class Result
    class Day < Result
      attr_reader :date

      def initialize(date, bytes_received, bytes_sent)
        @date = date
        super(bytes_received, bytes_sent)
      end

      def self.extract_from_xml_element(element)
        date = Utils.extract_date_from_xml_element(element)
        new(date, *Utils.extract_transmitted_bytes_from_xml_element(element))
      end

      def <=>(other)
        return nil unless other.respond_to?(:bytes_transmitted)
        return nil unless other.respond_to?(:date)
        [date, bytes_transmitted] <=> [other.date, other.bytes_transmitted]
      end
    end
  end
end
