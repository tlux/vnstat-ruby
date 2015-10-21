describe Vnstat::Document do
  describe '#version' do
    subject do
      described_class.new('<vnstat version="1.23" xmlversion="1"></vnstat>')
    end

    it 'returns the version from vnstat element' do
      expect(subject.version).to eq '1.23'
    end
  end

  describe '#interfaces' do
    subject do
      data = <<-XML
        <vnstat version="0.00" xmlversion="1">
          <interface id="eth0"></interface>
          <interface id="wlan0"></interface>
        </vnstat>
      XML
      described_class.new(data)
    end

    it 'returns an Array' do
      expect(subject.interfaces).to be_an Array
    end

    it 'containts items of type Vnstat::Interface' do
      all_items_interfaces = subject.interfaces.all? do |interface|
        interface.is_a?(Vnstat::Interface)
      end
      expect(all_items_interfaces).to be true
    end
  end
end
