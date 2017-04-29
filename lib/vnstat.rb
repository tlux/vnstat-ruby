# frozen_string_literal: true

require 'date'
require 'nokogiri'

##
# The Vnstat namespace.
module Vnstat
  autoload :Configuration, 'vnstat/configuration'
  autoload :Document, 'vnstat/document'
  autoload :Interface, 'vnstat/interface'
  autoload :InterfaceCollection, 'vnstat/interface_collection'
  autoload :Parser, 'vnstat/parser'
  autoload :Result, 'vnstat/result'
  autoload :SystemCall, 'vnstat/system_call'
  autoload :Traffic, 'vnstat/traffic'
  autoload :Utils, 'vnstat/utils'

  autoload :Error, 'vnstat/error'
  autoload :ExecutableNotFound, 'vnstat/errors/executable_not_found'
  autoload :UnknownInterface, 'vnstat/errors/unknown_interface'

  module_function

  ##
  # The configuration of the Vnstat environment.
  #
  # @return [Configuration]
  def config
    @config ||= Configuration.new
  end

  ##
  # Configures the Vnstat environment.
  #
  # @yieldparam [Configuration] config The environment configuration.
  # @return [Configuration]
  def configure
    yield(config)
    config
  end

  ##
  # Returns traffic information for the given interface.
  #
  # @param [String] id The network interface identifier.
  # @return [Interface]
  def [](id)
    interfaces[id]
  end

  ##
  # Returns traffic information for all known interfaces.
  #
  # @return [InterfaceCollection]
  def interfaces
    InterfaceCollection.open
  end

  ##
  # Returns information for the currently installed version of vnstat.
  #
  # @return [String]
  def version
    Utils.call_executable('-v')
  end
end
