# frozen_string_literal: true

module Vnstat
  ##
  # A module containing several utility methods responsible for document
  # parsing.
  module Parser
    module_function

    ##
    # Extracts the year and month from the given XML element.
    #
    # @param [Nokogiri::XML::Element] element The XML element.
    # @return [Array<Integer, Integer>] An Array consisting of year and month.
    def extract_month_from_xml_element(element)
      month = element.xpath('date/month').text.to_i
      year = element.xpath('date/year').text.to_i
      [year, month]
    end

    ##
    # Extracts the date from the given XML element.
    #
    # @param [Nokogiri::XML::Element] element The XML element.
    # @return [Date]
    def extract_date_from_xml_element(element)
      day = element.xpath('date/day').text.to_i
      year, month = extract_month_from_xml_element(element)
      Date.new(year, month, day)
    end

    ##
    # Extracts the date and time from the given XML element.
    #
    # @param [Nokogiri::XML::Element] element The XML element.
    # @return [DateTime]
    def extract_datetime_from_xml_element(element)
      date = extract_date_from_xml_element(element)
      hour = element.xpath('time/hour').text.to_i
      minute = element.xpath('time/minute').text.to_i
      DateTime.new(date.year, date.month, date.day, hour, minute, 0,
                   DateTime.now.offset)
    end

    ##
    # Extracts the bytes received and sent from the given XML element.
    #
    # @param [Nokogiri::XML::Element] element The XML element.
    # @return [Array<Integer, Integer>] An Array consisting of bytes received
    #   and bytes sent.
    def extract_transmitted_bytes_from_xml_element(element)
      bytes_received = element.xpath('rx').text.to_i * 1024
      bytes_sent = element.xpath('tx').text.to_i * 1024
      [bytes_received, bytes_sent]
    end
  end
end
