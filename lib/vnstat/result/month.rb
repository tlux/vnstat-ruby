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
          *Utils.extract_month_from_xml_element(element),
          *Utils.extract_transmitted_bytes_from_xml_element(element)
        )
      end
    end
  end
end
