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
      data.xpath('vnstat').attr('version').text
    end

    def [](interface_id)
      interfaces_hash.fetch(interface_id.to_s) do
        fail UnknownInterfaceError.new(interface_id.to_s),
             "Unknown interface: #{interface_id}"
      end
    end

    def interfaces
      interfaces_hash.values
    end

    private

    def interfaces_hash
      @interfaces_hash ||= begin
        elements = data.xpath('//interface')
        elements.each_with_object({}) do |node, hash|
          id = node[:id]
          hash[id] = Interface.new(self, id)
        end
      end
    end
  end
end
