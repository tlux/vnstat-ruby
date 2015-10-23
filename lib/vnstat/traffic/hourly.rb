module Vnstat
  module Traffic
    class Hourly < Base
      private

      def entries_hash
        elements = traffic_data.xpath('months/month')
        elements.each_with_object({}) do |element, hash|
          result = Result::Hour.extract_from_xml_element(element)
          hash[[result.date, result.hour]] = result
        end
      end
    end
  end
end
