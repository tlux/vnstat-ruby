module Vnstat
  class Document
    def initialize(data)
      self.data = data
    end

    def self.open(*args)
      new(*args, load_data(*args))
    end

    def self.load_data(*args)
      fail NotImplementedError, "Please override #{name}.#{__method__}"
    end

    attr_reader :data

    ##
    # Replaces the data in the document with the data from the given String,
    # parsing the input if necessary.
    #
    # @param [String] A string representing the document.
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
