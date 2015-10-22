require 'open3'

module Vnstat
  module Utils
    module_function

    def system_call(*args)
      exit_status = nil
      success_result, error_result = nil
      Open3.popen3(*args) do |_, stdout, stderr, wait_thr|
        success_result = stdout.readlines.join.chomp
        error_result = stderr.readlines.join.chomp
        exit_status = wait_thr.value
      end
      return success_result if exit_status.success?
      yield(error_result) if block_given?
    end

    def extract_datetime_from_xml_element(node)
      date_node = node.xpath('date')
      day = Integer(date_node.xpath('day').text)
      month = Integer(date_node.xpath('month').text)
      year = Integer(date_node.xpath('year').text)
      Date.new(year, month, day)
    end

    def extract_datetime_from_xml_element(node)
      date = extract_datetime_from_xml_element(node)
      time_node = node.xpath('time')
      hour = Integer(time_node.xpath('hour').text)
      minute = Integer(time_node.xpath('minute').text)
      DateTime.new(date.year, date.month, date.day, hour, minute)
    end
  end
end
