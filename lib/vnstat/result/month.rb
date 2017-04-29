# frozen_string_literal: true

module Vnstat
  class Result
    ##
    # A class representing a tracking result for a specific month.
    #
    # @!attribute [r] year
    #  @return [Integer] The year the result was captured in.
    # @!attribute [r] month
    #  @return [Integer] The month the result was captured in.
    class Month < Result
      attr_reader :year, :month

      ##
      # Initializes the {Month}.
      #
      # @param [Integer] year The year the result was captured in.
      # @param [Integer] month The month the result was captured in.
      # @param [Integer] bytes_received The received bytes.
      # @param [Integer] bytes_sent The sent bytes.
      def initialize(year, month, bytes_received, bytes_sent)
        @year = year
        @month = month
        super(bytes_received, bytes_sent)
      end

      ##
      # Initializes a {Month} using the the data contained in the given XML
      # element.
      #
      # @param [Nokogiri::XML::Element] element The XML element.
      # @return [Month]
      def self.extract_from_xml_element(element)
        new(
          *Parser.extract_month_from_xml_element(element),
          *Parser.extract_transmitted_bytes_from_xml_element(element)
        )
      end

      ##
      # @return [Integer, nil]
      def <=>(other)
        return nil unless other.respond_to?(:bytes_transmitted)
        return nil if !other.respond_to?(:year) || !other.respond_to?(:month)
        [year, month, bytes_transmitted] <=>
          [other.year, other.month, other.bytes_transmitted]
      end
    end
  end
end
