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
    
    def delete
      system("vnstat --delete -i #{id}")
    end
    
    def reset
      system("vnstat --reset -i #{id}")
    end

    def nick
      @nick ||= data.xpath('nick').text
    end

    def nick=(nick)
      system("vnstat -i #{id} --nick #{nick} --update")
      @nick = nick
    end
    
    alias_method :name, :nick
    alias_method :name=, :nick=

    def created_on
      Utils.extract_date_from_xml_element(data.xpath('created'))
    end

    def updated_at
      Utils.extract_datetime_from_xml_element(data.xpath('updated'))
    end

    def total
      Result.extract_from_xml_element(data.xpath('traffic/total'))
    end

    def hours
      @hours ||= Traffic::Hourly.new(self)
    end

    def days
      @days ||= Traffic::Daily.new(self)
    end

    def months
      @months ||= Traffic::Monthly.new(self)
    end
  end
end