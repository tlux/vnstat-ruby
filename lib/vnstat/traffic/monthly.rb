module Vnstat
  module Traffic
    class Monthly < Base
      def entries
        interface.data.xpath('traffic/months/month').map do |element|
          Result.extract_from_xml_element(element)
        end
      end
    end
  end
end
