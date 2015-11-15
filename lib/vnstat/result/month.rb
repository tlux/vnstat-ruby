module Vnstat
  class Result
    class Month < Result
      attr_reader :year, :month

      def initialize(year, month, bytes_received, bytes_sent)
        @year = year
        @month = month
        super(bytes_received, bytes_sent)
      end

      def self.extract_from_xml_element(element)
        new(
          *Parser.extract_month_from_xml_element(element),
          *Parser.extract_transmitted_bytes_from_xml_element(element)
        )
      end

      def <=>(other)
        return nil unless other.respond_to?(:bytes_transmitted)
        return nil if !other.respond_to?(:year) || !other.respond_to?(:month)
        [year, month, bytes_transmitted] <=>
          [other.year, other.month, other.bytes_transmitted]
      end
    end
  end
end
