module Vnstat
  module Traffic
    class Daily < Base
      def entries
        interface.data.xpath('traffic/days/day').map do |element|
          Result.extract_from_xml_element(element)
        end
      end
    end
  end
end
