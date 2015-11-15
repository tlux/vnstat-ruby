require 'open3'

module Vnstat
  class SystemCall
    attr_reader :args, :success_result, :error_result, :exit_status

    def initialize(*args)
      @args = args.flatten
    end

    def self.call(*args)
      new(*args).call
    end

    def call
      Open3.popen3(*args) do |_, stdout, stderr, wait_thr|
        @success_result = readlines(stdout)
        @error_result = readlines(stderr)
        @exit_status = wait_thr.value
      end
      self
    end

    def called?
      !exit_status.nil?
    end

    def result
      success? ? success_result : error_result
    end

    def success?
      fail 'Command not invoked' unless called?
      exit_status.success?
    end

    def error?
      !success?
    end

    def to_s
      call unless called?
      result.to_s
    end

    private

    def readlines(io)
      io.readlines.join.chomp
    end
  end
end
