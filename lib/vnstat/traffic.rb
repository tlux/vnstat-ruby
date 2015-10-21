module Vnstat
  class Traffic < Struct.new(:bytes_received, :bytes_sent)
    def self.extract(node)
      bytes_received = Integer(node.xpath('rx').text) * 1024
      bytes_sent = Integer(node.xpath('tx').text) * 1024
      new(bytes_received, bytes_sent)
    end

    def bytes_transmitted
      bytes_received + bytes_sent
    end
  end
end
