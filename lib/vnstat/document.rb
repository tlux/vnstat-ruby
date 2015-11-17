module Vnstat
  # A class encapsulating document data.
  #
  # @attr_reader [Nokogiri::XML::Document] data The underlying XML document.
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
    def self.load_data(*args)
      fail NotImplementedError, "Please override #{name}.#{__method__}"
    end

    attr_reader :data

    ##
    # Sets the raw XML data for the {Document}.
    #
    # @param [String] data A string representing the document.
    # @raise [ArgumentError] Raised if the specified data was nil.
    def data=(data)
      fail ArgumentError, 'No document data specified' if data.nil?
      @data = Nokogiri::XML.parse(data)
    end

    ##
    # Returns the version as specified in the vnstat element.
    #
    # @return [String]
    def version
      data.xpath('vnstat').attr('version').text
    end

    ##
    # Returns the XML version as specified in the vnstat element.
    #
    # @return [String]
    def xml_version
      data.xpath('vnstat').attr('xmlversion').text
    end
  end
end
