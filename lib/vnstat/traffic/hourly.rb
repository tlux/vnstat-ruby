module Vnstat
  module Traffic
    ##
    # A class encapsulating hourly tracking information.
    class Hourly < Base
      ##
      # Fetches a single {Result::Hour} from the collection.
      #
      # @return [Result::Hour]
      #
      # @overload [](date, hour)
      #   @param [Date] date
      #   @param [Integer] hour
      #
      # @overload [](year, month, day, hour)
      #   @param [Integer] year
      #   @param [Integer] month
      #   @param [Integer] day
      #   @param [Integer] hour
      def [](*args)
        args_count = args.count
        hour = args.pop
        date = case args_count
               when 2 then args.first
               when 4 then Date.new(*args)
               else
                 raise ArgumentError, 'wrong number of arguments ' \
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
