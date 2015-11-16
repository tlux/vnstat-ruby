module Vnstat
  ##
  # A namespace incorporating all kinds of traffic collections.
  module Traffic
    autoload :Base, 'vnstat/traffic/base'
    autoload :Daily, 'vnstat/traffic/daily'
    autoload :Hourly, 'vnstat/traffic/hourly'
    autoload :Monthly, 'vnstat/traffic/monthly'
    autoload :Tops, 'vnstat/traffic/tops'
  end
end
