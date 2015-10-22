module Vnstat
  module Traffic
    class Hourly < Base
      def entries
        interface.data.xpath('traffic/hours/hour').map do |element|
          Result.extract_from_xml_element(element)
        end
      end
    end
  end
end
