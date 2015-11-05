module Vnstat
  class UnknownInterface < Error
    attr_reader :interface_id

    def initialize(interface_id)
      @interface_id = interface_id
    end
  end
end
