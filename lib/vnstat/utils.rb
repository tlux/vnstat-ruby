module Vnstat
  ##
  # A module containing several utility methods.
  module Utils
    module_function

    ##
    # Initiates a system call with the given arguments.
    #
    # @overload system_call(*args)
    #   @param [Array<String>] args The arguments for the system call.
    #   @return [String] The output of STDOUT or STDERR, depending of the exit
    #     status of the called command.
    #
    # @overload system_call(*args, &block)
    #   @param [Array<String>] args The arguments for the system call.
    #   @yield [error_result] A block yielded when the called command exited
    #     unsuccessfully.
    #   @yieldparam [String] error_result The STDERR output.
    #   @return [Object] The value the called block returns.
    def system_call(*args)
      system_call = SystemCall.call(*args)
      return system_call.success_result if system_call.success?
      return yield(system_call.error_result) if block_given?
      system_call.error_result
    end

    ##
    # Initiates a system call with the given arguments and returning whether the
    # command has been executed successfully.
    #
    # @param [Array<String>] args The arguments for the system call.
    # @return [true, false] Indicates whether the command has been executed
    #   successfully (true), or not (false).
    def system_call_returning_status(*args)
      SystemCall.call(*args).success?
    end

    ##
    # Calls the vnstat CLI with the given arguments.
    #
    # @overload call_executable(*args)
    #   @param [Array<String>] args The arguments for the system call.
    #   @return [String] The output of STDOUT or STDERR, depending of the exit
    #     status of the called command.
    #
    # @overload call_executable(*args, &block)
    #   @param [Array<String>] args The arguments for the system call.
    #   @yield [error_result] A block yielded when the called command exited
    #     unsuccessfully.
    #   @yieldparam [String] error_result The STDERR output.
    #   @return [Object] The value the called block returns.
    def call_executable(*args, &block)
      system_call(Vnstat.config.executable_path, *args, &block)
    end

    ##
    # Calls the vnstat CLI with the given arguments and returning whether the
    # command has been executed successfully.
    #
    # @param [Array<String>] args The arguments for the system call.
    # @return [true, false] Indicates whether the command has been executed
    #   successfully (true), or not (false).
    def call_executable_returning_status(*args)
      system_call_returning_status(Vnstat.config.executable_path, *args)
    end
  end
end
