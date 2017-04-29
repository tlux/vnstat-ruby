# frozen_string_literal: true

module Vnstat
  #
  # An exception that is raised when the specified interface could not be found
  # among the known ones.
  class UnknownInterface < Error
    attr_reader :interface_id

    def initialize(interface_id)
      @interface_id = interface_id
    end
  end
end
