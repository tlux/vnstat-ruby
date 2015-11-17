module Vnstat
  ##
  # A class encapsulating configurations of the Vnstat environment.
  #
  # @attr_writer [String] executable_path Sets the location of the vnstat
  #   executable.
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
        fail ExecutableNotFound, 'Unable to locate vnstat executable'
      end
    end

    attr_writer :executable_path
  end
end
