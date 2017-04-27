module Vnstat
  module Traffic
    ##
    # A class encapsulating daily tracking information.
    class Daily < Base
      ##
      # Fetches a single {Result::Day} from the collection.
      #
      # @return [Result::Day]
      #
      # @overload [](date)
      #   @param [Date] date
      #
      # @overload [](year, month, day)
      #   @param [Integer] year
      #   @param [Integer] month
      #   @param [Integer] day
      def [](*args)
        date = case args.count
               when 1 then args.first
               when 3 then Date.new(*args)
               else
                 raise ArgumentError, 'wrong number of arguments ' \
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
