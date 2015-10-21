module Vnstat
  class Document
    attr_reader :data

    def initialize(data)
      @data = Nokogiri::XML.parse(data)
    end

    def self.open
      new(Utils.system_readlines(Vnstat.config.executable_path, '--xml'))
    end

    def interfaces
      []
    end
  end
end
