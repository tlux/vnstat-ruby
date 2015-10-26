module Vnstat
  class Document
    def initialize(data)
      self.data = data
    end

    def self.open(*args)
      new(*args, load_data(*args))
    end

    ##
    # Returns the version as specified in the vnstat element.
    #
    # @return [String]
    def version
      data.xpath('vnstat').attr('version').text
    end

    attr_reader :data

    def data=(data)
      @data = data && Nokogiri::XML.parse(data)
    end
  end
end
