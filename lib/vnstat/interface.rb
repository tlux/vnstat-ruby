module Vnstat
  class Interface < Document
    attr_reader :id

    def initialize(id, data)
      super(data)
      @id = id
    end

    def self.load_data(id)
      Utils.call_executable('-i', id, '--xml')
    end

    ##
    # Determines whether the interface is the same as another.
    #
    # @return [true, false]
    def ==(other)
      return false unless other.respond_to?(:id)
      id == other.id
    end

    ##
    # Refreshes data cached in the current instance.
    #
    # @return [Vnstat::Interface]
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
    # @return [Vnstat::Interface]
    def reset
      Utils.call_executable_returning_status('--reset', '-i', id)
      reload
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
    # @param [String] name The alias name for the interface.
    def nick=(nick)
      Utils.call_executable_returning_status(
        '-i', id, '--nick', nick, '--update'
      )
      @nick = nick
    end

    alias_method :name, :nick
    alias_method :name=, :nick=

    def created_on
      Parser.extract_date_from_xml_element(interface_data.xpath('created'))
    end

    def updated_at
      Parser.extract_datetime_from_xml_element(interface_data.xpath('updated'))
    end

    def total
      Result.extract_from_xml_element(interface_data.xpath('traffic/total'))
    end

    def hours
      @hours ||= Traffic::Hourly.new(self)
    end

    def days
      @days ||= Traffic::Daily.new(self)
    end

    def months
      @months ||= Traffic::Monthly.new(self)
    end

    private

    def interface_data
      data.xpath("//interface[@id='#{id}']")
    end
  end
end
