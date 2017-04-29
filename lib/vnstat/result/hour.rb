# frozen_string_literal: true

module Vnstat
  class Result
    ##
    # A class representing a tracking result for a specific hour.
    #
    # @attr_reader [Date] date The date the result was captured on.
    # @attr_reader [Integer] hour The hour the result was captured at.
    class Hour < Result
      include DateDelegation
      include TimeComparable

      attr_reader :date, :hour

      ##
      # Initializes the {Hour}.
      #
      # @param [Date] date The date the result was captured on.
      # @param [Integer] hour The hour the result was captured at.
      # @param [Integer] bytes_received The received bytes.
      # @param [Integer] bytes_sent The sent bytes.
      def initialize(date, hour, bytes_received, bytes_sent)
        @date = date
        @hour = hour
        super(bytes_received, bytes_sent)
      end

      ##
      # Initializes a {Hour} using the the data contained in the given XML
      # element.
      #
      # @param [Nokogiri::XML::Element] element The XML element.
      # @return [Hour]
      def self.extract_from_xml_element(element)
        date = Parser.extract_date_from_xml_element(element)
        hour = Integer(element.attr('id').to_s)
        new(
          date,
          hour,
          *Parser.extract_transmitted_bytes_from_xml_element(element)
        )
      end

      ##
      # @return [Integer, nil]
      def <=>(other)
        return nil unless other.respond_to?(:bytes_transmitted)
        return nil unless other.respond_to?(:time)
        [time, bytes_transmitted] <=> [other.time, other.bytes_transmitted]
      end

      ##
      # The time the result was captured.
      #
      # @return [DateTime]
      def time
        DateTime.new(year, month, day, hour, 0, 0, DateTime.now.offset)
      end
    end
  end
end
