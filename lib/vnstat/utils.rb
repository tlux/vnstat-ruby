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

    def system_call_returning_status(*args)
      success = true
      system_call(*args) { success = false }
      success
    end

    def call_executable(*args, &block)
      system_call(Vnstat.config.executable_path, *args, &block)
    end

    def call_executable_returning_status(*args)
      system_call_returning_status(Vnstat.config.executable_path, *args)
    end
  end
end
