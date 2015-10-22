module Vnstat
  module Result
    class Base < Struct.new(:bytes_received, :bytes_sent)
      def self.extract_from_xml_element(element, *args)
        bytes_received = Integer(element.xpath('rx').text) * 1024
        bytes_sent = Integer(element.xpath('tx').text) * 1024
        new(bytes_received, bytes_sent, *args)
      end

      def bytes_transmitted
        bytes_received + bytes_sent
      end
    end
  end
end
