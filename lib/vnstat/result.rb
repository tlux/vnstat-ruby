module Vnstat
  class Result
    autoload :Minute, 'vnstat/result/minute'
    autoload :Day, 'vnstat/result/day'
    autoload :Hour, 'vnstat/result/hour'
    autoload :Month, 'vnstat/result/month'

    autoload :DateDelegation, 'vnstat/result/date_delegation'
    autoload :TimeComparable, 'vnstat/result/time_comparable'

    include Comparable

    attr_reader :bytes_received, :bytes_sent

    def initialize(bytes_received, bytes_sent)
      @bytes_received = bytes_received
      @bytes_sent = bytes_sent
    end

    def self.extract_from_xml_element(element)
      new(*Parser.extract_transmitted_bytes_from_xml_element(element))
    end

    def bytes_transmitted
      bytes_received + bytes_sent
    end

    def <=>(other)
      return nil unless other.respond_to?(:bytes_transmitted)
      bytes_transmitted <=> other.bytes_transmitted
    end
  end
end
