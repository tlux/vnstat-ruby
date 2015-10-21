module Vnstat
  module Utils
    module_function

    def system_readlines(*args)
      result = nil
      IO.popen(args) do |io|
        result = io.readlines.join.chomp
      end
      result if $?.success?
    end
  end
end
