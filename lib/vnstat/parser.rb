module Vnstat
  module Parser
    module_function

    def extract_month_from_xml_element(element)
      month = Integer(element.xpath('date/month').text)
      year = Integer(element.xpath('date/year').text)
      [year, month]
    end

    def extract_date_from_xml_element(element)
      day = Integer(element.xpath('date/day').text)
      year, month = extract_month_from_xml_element(element)
      Date.new(year, month, day)
    end

    def extract_datetime_from_xml_element(element)
      date = extract_date_from_xml_element(element)
      hour = Integer(element.xpath('time/hour').text)
      minute = Integer(element.xpath('time/minute').text)
      DateTime.new(date.year, date.month, date.day, hour, minute)
    end

    def extract_transmitted_bytes_from_xml_element(element)
      bytes_received = Integer(element.xpath('rx').text) * 1024
      bytes_sent = Integer(element.xpath('tx').text) * 1024
      [bytes_received, bytes_sent]
    end
  end
end
