module Vnstat
  class Document
    attr_reader :data

    def initialize(data)
      @data = Nokogiri::XML.parse(data)
    end

    def self.open
      new(Utils.system_readlines(Vnstat.config.executable_path, '--xml'))
    end

    def version
      data.xpath('vnstat').first[:version]
    end

    def interfaces
      data.xpath('//interface').map do |node|
        name = node[:id]
        Interface.new(self, name)
      end
    end
  end
end
