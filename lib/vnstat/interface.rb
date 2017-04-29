# frozen_string_literal: true

module Vnstat
  ##
  # A class encapsulating traffic information for a specific network interface.
  #
  # @!attribute [r] id
  #   @return [String] The network interface identifier.
  class Interface < Document
    attr_reader :id

    ##
    # Initializes the {Interface}.
    #
    # @param [String] id The network interface identifier.
    # @param [String] data The raw XML data.
    def initialize(id, data)
      super(data)
      @id = id
    end

    ##
    # Retrieves the raw XML data for the given interface identifier.
    #
    # @param [String] id The network interface identifier.
    # @return [String]
    def self.load_data(id)
      Utils.call_executable('-i', id, '--xml')
    end

    ##
    # Determines whether the interface is the same as another.
    #
    # @param [Interface] other The compared object.
    # @return [true, false]
    def ==(other)
      return false unless other.respond_to?(:id)
      id == other.id
    end

    ##
    # Refreshes data cached in the current instance.
    #
    # @return [Interface]
    def reload
      self.data = self.class.load_data(id)
      @nick = nil
      self
    end

    ##
    # Deletes the traffic database for the interface.
    #
    # @return [true, false]
    def delete
      Utils.call_executable_returning_status('--delete', '-i', id)
    end

    ##
    # Reset the internal counters in the database for the selected interface.
    # Use this if the interface goes down and back up, otherwise that interface
    # will get some extra traffic to its database. Not needed when the daemon is
    # used.
    #
    # @return [Interface]
    def reset
      reload if Utils.call_executable_returning_status('--reset', '-i', id)
      self
    end

    ##
    # Returns the alias name for the interface.
    #
    # @return [String]
    def nick
      @nick ||= interface_data.xpath('nick').text
    end

    #
    # Sets the alias name for the interface.
    #
    # @raise [Error] Raised when a new nickname could not be set.
    # @param [String] nick The alias name for the interface.
    def nick=(nick)
      success = Utils.call_executable_returning_status(
        '-i', id, '--nick', nick, '--update'
      )
      unless success
        raise Error, "Unable to set nickname for interface (#{id}). " \
                    'Please make sure the vnstat daemon is not running while ' \
                    'performing this operation.'
      end
      @nick = nick
    end

    alias name nick
    alias name= nick=

    ##
    # The date on which tracking of the interface began.
    # @return [Date]
    #
    def created_on
      Parser.extract_date_from_xml_element(interface_data.xpath('created'))
    end

    ##
    # The date and time on which the tracking information for the interface
    # were updated.
    #
    # @return [DateTime]
    def updated_at
      Parser.extract_datetime_from_xml_element(interface_data.xpath('updated'))
    end

    ##
    # Returns information about the total traffic.
    #
    # @return [Result]
    def total
      Result.extract_from_xml_element(interface_data.xpath('traffic/total'))
    end

    ##
    # Returns information about the hourly traffic.
    #
    # @return [Traffic::Hourly]
    def hours
      @hours ||= Traffic::Hourly.new(self)
    end

    ##
    # Returns information about the daily traffic.
    #
    # @return [Traffic::Daily]
    def days
      @days ||= Traffic::Daily.new(self)
    end

    ##
    # Returns information about the monthly traffic.
    #
    # @return [Traffic::Monthly]
    def months
      @months ||= Traffic::Monthly.new(self)
    end

    ##
    # Returns information about the traffic tops.
    #
    # @return [Traffic::Tops]
    def tops
      @tops ||= Traffic::Tops.new(self)
    end

    ##
    # A human readable representation of the {Interface}.
    #
    # @return [String]
    def inspect
      "#<#{self.class.name} id: #{id.inspect}>"
    end

    private

    def interface_data
      data.xpath("//interface[@id='#{id}']")
    end
  end
end
