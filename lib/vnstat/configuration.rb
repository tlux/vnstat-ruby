# frozen_string_literal: true

module Vnstat
  ##
  # A class encapsulating configurations of the Vnstat environment.
  #
  # @!attribute executable_path
  #   @return The location of the vnstat executable.
  class Configuration
    ##
    # Initializes the {Configuration}.
    def initialize
      reset
    end

    ##
    # Restores the configuration defaults.
    #
    # @return [Configuration]
    def reset
      @executable_path = nil
      self
    end

    ##
    # Returns the location of the vnstat executable.
    #
    # @return [String]
    def executable_path
      @executable_path ||= Utils.system_call('which', 'vnstat') do
        raise ExecutableNotFound, 'Unable to locate vnstat executable'
      end
    end

    attr_writer :executable_path
  end
end
