require 'open3'

module Vnstat
  ##
  # A class responsible for communication with command line interfaces.
  #
  # @attr_reader [Array] args
  # @attr_reader [String, nil] success_result The STDOUT output of the called
  #   command.
  # @attr_reader [String, nil] error_result The STDERR output of the called
  #   command.
  # @attr_reader [Process::Status, nil] exit_status The exit status of the
  #   called command.
  class SystemCall
    attr_reader :args, :success_result, :error_result, :exit_status

    ##
    # Initializes the {SystemCall}.
    #
    # @param [Array] args The command line arguments.
    def initialize(*args)
      @args = args.flatten
    end

    ##
    # Initializes and calls the {SystemCall}.
    #
    # @param [Array] args The command line arguments.
    # @return [SystemCall]
    def self.call(*args)
      new(*args).call
    end

    ##
    # Calls the command.
    #
    # @return [SystemCall]
    def call
      Open3.popen3(*args) do |_, stdout, stderr, wait_thr|
        @success_result = readlines(stdout)
        @error_result = readlines(stderr)
        @exit_status = wait_thr.value
      end
      self
    end

    ##
    # Determines whether the command has been called.
    #
    # @return [true, false]
    def called?
      !exit_status.nil?
    end

    ##
    # Returns the command result.
    #
    # @return [String] Returns result from {#success_result} when command exited
    #   successfully. Otherwise returns result from {#error_result}.
    # @raise [RuntimeError] Raises when the command has not yet been called.
    def result
      success? ? success_result : error_result
    end

    ##
    # Indicates whether the command has been executed successfully.
    #
    # @raise [RuntimeError] Raises when the command has not yet been called.
    # @return [true, false]
    def success?
      fail 'Command not invoked' unless called?
      exit_status.success?
    end

    ##
    # Indicates whether the command has not been executed successfully.
    #
    # @raise [RuntimeError] Raises when the command has not yet been called.
    # @return [true, false]
    def error?
      !success?
    end

    private

    def readlines(io)
      io.readlines.join.chomp
    end
  end
end
