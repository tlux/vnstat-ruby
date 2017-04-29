# frozen_string_literal: true

module Vnstat
  ##
  # An exception that is raised when the vnstat CLI could not be found on the
  # machine.
  class ExecutableNotFound < Error
  end
end
