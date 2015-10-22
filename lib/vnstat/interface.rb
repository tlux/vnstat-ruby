module Vnstat
  class Interface
    attr_reader :document, :id

    def initialize(document, id)
      @document = document
      @id = id
    end

    def data
      document.data.xpath("//interface[@id='#{id}']")
    end

    def nick
      data.xpath('nick').text
    end
    
    alias_method :name, :nick

    def created_on
      Utils.extract_date(data.xpath('created'))
    end

    def updated_at
      Utils.extract_datetime(data.xpath('updated'))
    end

    def total
      Traffic.extract(data.xpath('traffic/total'))
    end
  end
end