module Vnstat
  class Result
    class Hour < Result
      attr_reader :date, :hour

      def initialize(date, hour, bytes_received, bytes_sent)
        @date = date
        @hour = hour
        super(bytes_received, bytes_sent)
      end

      def self.extract_from_xml_element(element)
        date = Utils.extract_date_from_xml_element(element)
        hour = Integer(element.attr('id').value)
        new(date, hour, *Utils.extract_transmitted_bytes_from_xml_element(element))
      end
    end
  end
end
