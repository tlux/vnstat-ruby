require 'nokogiri'

module Vnstat
  autoload :Configuration, 'vnstat/configuration'
  autoload :Document, 'vnstat/document'
  autoload :Interface, 'vnstat/interface'
  autoload :InterfaceCollection, 'vnstat/interface_collection'
  autoload :Parser, 'vnstat/parser'
  autoload :Result, 'vnstat/result'
  autoload :Traffic, 'vnstat/traffic'
  autoload :Utils, 'vnstat/utils'

  autoload :Error, 'vnstat/error'
  autoload :ExecutableNotFound, 'vnstat/errors/executable_not_found'
  autoload :UnknownInterface, 'vnstat/errors/unknown_interface'

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
