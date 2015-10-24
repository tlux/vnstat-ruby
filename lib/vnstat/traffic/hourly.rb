module Vnstat
  module Traffic
    class Hourly < Base
      def [](*args)
        args_count = args.count
        hour = args.pop
        date = case args_count
               when 2 then args.first
               when 4 then Date.new(*args)
               else
                 fail ArgumentError, 'wrong number of arguments ' \
                                     "(#{args_count} for 2 or 4)"
               end
        entries_hash[[date, hour]]
      end

      private

      def entries_hash
        elements = traffic_data.xpath('hours/hour')
        elements.each_with_object({}) do |element, hash|
          result = Result::Hour.extract_from_xml_element(element)
          hash[[result.date, result.hour]] = result
        end
      end
    end
  end
end
