# frozen_string_literal: true

require 'nokogiri'

module Vnstat
  # A class encapsulating document data.
  #
  # @!attribute [r] data
  #   @return [Nokogiri::XML::Document] The underlying XML document.
  class Document
    ##
    # Initializes the document.
    #
    # @param [String] data The raw XML data.
    def initialize(data)
      self.data = data
    end

    ##
    # @return [Document]
    def self.open(*args)
      new(*args, load_data(*args))
    end

    ##
    # A hook used by {.open} that is intended to be overridden by subclasses.
    #
    # @raise [NotImplementedError]
    def self.load_data(*_args)
      raise NotImplementedError, "Please override #{name}.#{__method__}"
    end

    attr_reader :data

    ##
    # Sets the raw XML data for the {Document}.
    #
    # @param [String] data A string representing the document.
    # @raise [ArgumentError] Raised if the specified data was nil.
    def data=(data)
      raise ArgumentError, 'No document data specified' if data.nil?

      @data = Nokogiri::XML.parse(data.to_s)
    end

    ##
    # Returns the version as specified in the vnstat element.
    #
    # @return [String]
    def version
      attr = data.xpath('vnstat').attr('version')
      raise 'Unable to determine version' if attr.nil?

      attr.text
    end

    ##
    # Returns the XML version as specified in the vnstat element.
    #
    # @return [String]
    def xml_version
      attr = data.xpath('vnstat').attr('xmlversion')
      raise 'Unable to determine XML version' if attr.nil?

      attr.text
    end
  end
end
