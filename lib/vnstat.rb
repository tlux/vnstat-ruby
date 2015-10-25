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

  def call(*args)
    system([Vnstat.config.executable_path, *args].shelljoin)
  end

  def document
    Document.open
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