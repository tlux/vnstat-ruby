module Vnstat
  class Result
    ##
    # A class representing a tracking result for a specific day.
    #
    # @attr_reader [Date] date The date the result was captured on.
    class Day < Result
      include DateDelegation

      attr_reader :date

      ##
      # Initializes the {Day}.
      #
      # @param [Date] date The date the result was captured on.
      # @param [Integer] bytes_received The received bytes.
      # @param [Integer] bytes_sent The sent bytes.
      def initialize(date, bytes_received, bytes_sent)
        @date = date
        super(bytes_received, bytes_sent)
      end

      ##
      # Initializes a {Day} using the the data contained in the given XML
      # element.
      #
      # @param [Nokogiri::XML::Element] element The XML element.
      # @return [Day]
      def self.extract_from_xml_element(element)
        new(
          Parser.extract_date_from_xml_element(element),
          *Parser.extract_transmitted_bytes_from_xml_element(element)
        )
      end

      ##
      # @return [Integer, nil]
      def <=>(other)
        return nil unless other.respond_to?(:bytes_transmitted)
        return nil unless other.respond_to?(:date)
        [date, bytes_transmitted] <=> [other.date, other.bytes_transmitted]
      end
    end
  end
end
