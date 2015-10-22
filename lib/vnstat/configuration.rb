module Vnstat
  class Configuration
    def initialize
      @executable_path = nil
    end

    def executable_path
      @executable_path ||=
        Utils.system_call('which', 'vnstat') ||
        fail(Error, 'Unable to locate vnstat executable')
    end

    attr_writer :executable_path
  end
end
