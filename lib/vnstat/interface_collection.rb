# frozen_string_literal: true

module Vnstat
  ##
  # A class encapsulating traffic information for all known network interfaces.
  class InterfaceCollection < Document
    include Enumerable

    ##
    # Retrieves the raw XML data for all interfaces.
    #
    # @return [String]
    def self.load_data
      Utils.call_executable('--xml')
    end

    ##
    # Sets the raw XML data for the {InterfaceCollection}.
    #
    # @param [String] data A string representing the document.
    def data=(data)
      super
      each { |interface| interface.data = data }
    end

    ##
    # Refreshes data cached in the current instance.
    #
    # @return [InterfaceCollection]
    def reload
      self.data = self.class.load_data
      self
    end

    ##
    # Returns the names of known interfaces.
    #
    # @return [Array<String>]
    def ids
      interfaces_hash.keys
    end

    ##
    # Returns traffic information for a certain interface.
    #
    # @param [String] id The name of the interface.
    # @raise [UnknownInterface] An error that is raised if the
    #   specified interface is not tracked.
    # @return [Interface]
    def [](id)
      interfaces_hash.fetch(id.to_s) do
        raise UnknownInterface.new(id.to_s),
              "Unknown interface: #{id}"
      end
    end

    ##
    # Iterates over each interface.
    #
    # @yieldparam [Interface] interface
    def each(&block)
      interfaces_hash.each_value(&block)
    end

    ##
    # Creates the traffic database for the given interface.
    #
    # @param [String] id The network interface identifier
    # @return [Interface, nil] The interface that has justed been added to
    #   tracking.
    def create(id)
      success = Utils.call_executable_returning_status('--create', '-i', id)
      return nil unless success

      reload
      self[id]
    end

    ##
    # Reset the total traffic counters and recount those using recorded months.
    #
    # @return [InterfaceCollection]
    def rebuild
      success = Utils.call_executable_returning_status('--rebuildtotal')
      reload if success
      self
    end

    ##
    # A human readable representation of the {InterfaceCollection}.
    #
    # @return [String]
    def inspect
      "#<#{self.class.name} ids: #{ids.inspect}>"
    end

    ##
    # The XML version that the CLI program uses.
    #
    # @return [String]
    def xml_version
      @xml_version ||= begin
        attr = data.xpath('/vnstat').attr('xmlversion')
        raise 'Unable to determine vnstat XML version' if attr.nil?

        attr.value
      end
    end

    private

    def interfaces_hash
      @interfaces_hash ||= begin
        id_attr = xml_version == '2' ? :name : :id
        elements = data.xpath('//interface')
        elements.each_with_object({}) do |node, hash|
          id = node[id_attr]
          hash[id] = Interface.new(id, data)
        end
      end
    end
  end
end
