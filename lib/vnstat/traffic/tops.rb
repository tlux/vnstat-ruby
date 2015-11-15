module Vnstat
  module Traffic
    class Tops < Base
      def each(&block)
        to_a.each(&block)
      end

      def [](index)
        to_a[index]
      end

      def to_a
        elements = traffic_data.xpath('tops/top')
        elements.map do |element|
          Result::Minute.extract_from_xml_element(element)
        end
      end
    end
  end
end
