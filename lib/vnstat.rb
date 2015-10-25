require 'nokogiri'
require 'shellwords'

module Vnstat
  autoload :Configuration, 'vnstat/configuration'
  autoload :Document, 'vnstat/document'
  autoload :Error, 'vnstat/error'
  autoload :Interface, 'vnstat/interface'
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

  def call(*args, &block)
    Utils.system_call(config.executable_path, *args, &block)
  end
  
  def call_returning_status(*args)
    Utils.system_call_returning_status(config.executable_path, *args)
  end

  def document
    Document.load_interfaces
  end

  def [](interface_id)
    document[interface_id]
  end

  def interfaces
    document.interfaces
  end

  def version
    document.version
  end
end