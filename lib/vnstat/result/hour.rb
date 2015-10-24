module Vnstat
  class Result
    class Hour < Result
      include DateDelegation

      attr_reader :date, :hour

      def initialize(date, hour, bytes_received, bytes_sent)
        @date = date
        @hour = hour
        super(bytes_received, bytes_sent)
      end

      def self.extract_from_xml_element(element)
        date = Utils.extract_date_from_xml_element(element)
        hour = Integer(element.attr('id').to_s)
        new(date, hour, *Utils.extract_transmitted_bytes_from_xml_element(element))
      end

      def <=>(other)
        return nil unless other.respond_to?(:bytes_transmitted)
        return nil if !other.respond_to?(:date) || !other.respond_to?(:hour)
        [date, hour, bytes_transmitted] <=>
          [other.date, other.hour, other.bytes_transmitted]
      end
    end
  end
end
