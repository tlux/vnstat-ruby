module Vnstat
  module Traffic
    class Monthly < Base
      def [](year, month)
        entries_hash[[year, month]]
      end

      private

      def entries_hash
        elements = traffic_data.xpath('months/month')
        elements.each_with_object({}) do |element, hash|
          result = Result::Month.extract_from_xml_element(element)
          hash[[result.year, result.month]] = result
        end
      end
    end
  end
end
