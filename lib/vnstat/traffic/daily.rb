module Vnstat
  module Traffic
    class Daily < Base
      def [](*args)
        date = case args.count
               when 1 then args.first
               when 3 then Date.new(*args)
               else
                 fail ArgumentError, 'wrong number of arguments ' \
                                     "(#{args.count} for 1 or 3)"
               end
        entries_hash[date]
      end

      private

      def entries_hash
        elements = traffic_data.xpath('days/day')
        elements.each_with_object({}) do |element, hash|
          result = Result::Day.extract_from_xml_element(element)
          hash[result.date] = result
        end
      end
    end
  end
end
