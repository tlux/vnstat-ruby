module Vnstat
  module Traffic
    autoload :Base, 'vnstat/traffic/base'
    autoload :Daily, 'vnstat/traffic/daily'
    autoload :Hourly, 'vnstat/traffic/hourly'
    autoload :Monthly, 'vnstat/traffic/monthly'
  end
end