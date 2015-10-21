module Vnstat
  autoload :Configuration, 'vnstat/configuration'

  module_function

  def config
    @config ||= Configuration.new
  end

  def configure
    yield(config)
  end
end
