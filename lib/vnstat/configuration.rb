module Vnstat
  class Configuration
    def initialize
      @executable_path = nil
    end

    def executable_path
      @executable_path ||=
        Utils.system_readlines('which', 'vnstat') ||
        fail(Error, 'Unable to find vnstat executable')
    end

    attr_writer :executable_path
  end
end
