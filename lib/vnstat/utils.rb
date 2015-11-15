module Vnstat
  module Utils
    module_function

    def system_call(*args)
      system_call = SystemCall.call(*args)
      return system_call.success_result if system_call.success?
      return yield(system_call.error_result) if block_given?
      system_call.error_result
    end

    def system_call_returning_status(*args)
      SystemCall.call(*args).success?
    end

    def call_executable(*args, &block)
      system_call(Vnstat.config.executable_path, *args, &block)
    end

    def call_executable_returning_status(*args)
      system_call_returning_status(Vnstat.config.executable_path, *args)
    end
  end
end
