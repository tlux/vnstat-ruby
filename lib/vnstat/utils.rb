module Vnstat
  module Utils
    module_function

    def system_readlines(*args)
      result = nil
      IO.popen(args) do |io|
        result = io.readlines.join.chomp
      end
      result if $?.success?
    end

    def extract_date(node)
      date_node = node.xpath('date')
      day = Integer(date_node.xpath('day').text)
      month = Integer(date_node.xpath('month').text)
      year = Integer(date_node.xpath('year').text)
      Date.new(year, month, day)
    end

    def extract_datetime(node)
      date = extract_date(node)
      time_node = node.xpath('time')
      hour = Integer(time_node.xpath('hour').text)
      minute = Integer(time_node.xpath('minute').text)
      DateTime.new(date.year, date.month, date.day, hour, minute)
    end
  end
end
