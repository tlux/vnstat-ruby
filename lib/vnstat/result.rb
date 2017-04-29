# frozen_string_literal: true

module Vnstat
  ##
  # A class representing a tracking result.
  #
  # @!attribute [r] bytes_received
  #   @return [Integer] The received bytes.
  # @!attribute [r] bytes_sent
  #   @return [Integer] The sent bytes.
  class Result
    autoload :DateDelegation, 'vnstat/result/date_delegation'
    autoload :Day, 'vnstat/result/day'
    autoload :Hour, 'vnstat/result/hour'
    autoload :Minute, 'vnstat/result/minute'
    autoload :Month, 'vnstat/result/month'
    autoload :TimeComparable, 'vnstat/result/time_comparable'

    include Comparable

    attr_reader :bytes_received, :bytes_sent

    ##
    # Initializes the {Result}.
    #
    # @param [Integer] bytes_received The received bytes.
    # @param [Integer] bytes_sent The sent bytes.
    def initialize(bytes_received, bytes_sent)
      @bytes_received = bytes_received
      @bytes_sent = bytes_sent
    end

    ##
    # Initializes a {Result} using the the data contained in the given XML
    # element.
    #
    # @param [Nokogiri::XML::Element] element The XML element.
    # @return [Result]
    def self.extract_from_xml_element(element)
      new(*Parser.extract_transmitted_bytes_from_xml_element(element))
    end

    ##
    # The transmitted bytes (both sent and received).
    #
    # @return [Integer]
    def bytes_transmitted
      bytes_received + bytes_sent
    end

    ##
    # @return [Integer, nil]
    def <=>(other)
      return nil unless other.respond_to?(:bytes_transmitted)
      bytes_transmitted <=> other.bytes_transmitted
    end
  end
end
