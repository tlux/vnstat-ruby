module Vnstat
  class InterfaceCollection < Document
    include Enumerable

    def self.load_data
      Utils.call_executable('--xml')
    end

    def data=(data)
      super
      each { |interface| interface.data = data }
    end

    ##
    # Reloads the collection of interfaces by fetching
    def reload
      self.data = self.class.load_data
      self
    end

    ##
    # Returns traffic information for a certain interface.
    #
    # @param [String] id The name of the interface.
    # @return [Vnstat::Interface]
    # @raise [Vnstat::UnknownInterface] An error that is raised if the
    #   specified interface is not tracked.
    def [](id)
      interfaces_hash.fetch(id.to_s) do
        fail UnknownInterface.new(id.to_s),
             "Unknown interface: #{id}"
      end
    end

    ##
    # Iterates over each interface.
    #
    # @yieldparam [Vnstat::Interface] interface
    def each(&block)
      interfaces_hash.each_value(&block)
    end

    ##
    # Creates the traffic database for the given interface.
    #
    # @param [String] id The name of the interface
    # @return [Vnstat::Interface, nil] The interface that has justed been
    #   added to tracking.
    def create(id)
      success = Utils.call_executable_returning_status('--create', '-i', id)
      return nil unless success
      reload
      self[id]
    end

    ##
    # Reset the total traffic counters and recount those using recorded months.
    #
    # @return [Vnstat::InterfaceCollection]
    def rebuild
      Utils.call_executable_returning_status('--rebuildtotal')
      reload
    end

    private

    def interfaces_hash
      @interfaces_hash ||= begin
        elements = data.xpath('//interface')
        elements.each_with_object({}) do |node, hash|
          id = node[:id]
          hash[id] = Interface.new(id, data)
        end
      end
    end
  end
end
