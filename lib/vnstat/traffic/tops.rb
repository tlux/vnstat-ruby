module Vnstat
  module Traffic
    ##
    # A class representing a collection of tracked tops.
    class Tops < Base
      ##
      # Iterates over all results in the collection.
      #
      # @overload each
      #   @return [Enumerator]
      #
      # @overload each(&block)
      #   @yield [result]
      #   @yieldparam [Result::Minute] result
      #   @return [Tops]
      def each(&block)
        to_a.each(&block)
      end

      ##
      # Fetches a single {Result::Minute} from the collection.
      #
      # @param [Integer] index The index of the entry in the collection.
      # @return [Result::Minute]
      def [](index)
        to_a[index]
      end

      ##
      # @return [Array<Result::Minute>]
      def to_a
        elements = traffic_data.xpath('tops/top')
        elements.map do |element|
          Result::Minute.extract_from_xml_element(element)
        end
      end
    end
  end
end
