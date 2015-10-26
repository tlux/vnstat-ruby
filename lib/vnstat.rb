require 'nokogiri'

module Vnstat
  autoload :Configuration, 'vnstat/configuration'
  autoload :Document, 'vnstat/document'
  autoload :Error, 'vnstat/error'
  autoload :Interface, 'vnstat/interface'
  autoload :InterfaceCollection, 'vnstat/interface_collection'
  autoload :Result, 'vnstat/result'
  autoload :Traffic, 'vnstat/traffic'
  autoload :UnknownInterfaceError, 'vnstat/unknown_interface_error'
  autoload :Utils, 'vnstat/utils'

  module_function

  def config
    @config ||= Configuration.new
  end

  def configure
    yield(config)
  end

  def [](id)
    interfaces[id]
  end

  def interfaces
    InterfaceCollection.open
  end

  def version
    Utils.call_executable('-v')
  end
end
