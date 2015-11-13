describe Vnstat::Document do
  subject do
    described_class.new('<vnstat version="1.23" xmlversion="1"></vnstat>')
  end

  describe '#initialize' do
    it 'invokes #data= forwarding the first argument' do
      expect_any_instance_of(described_class)
        .to receive(:data=).with('test')

      described_class.new('test')
    end
  end

  describe '#data=' do
    context 'when setting nil' do
      subject { described_class.new('<vnstat />') }

      before :each do
        subject.data = nil
      end

      it 'stores nil in #data' do
        expect(subject.data).to be nil
      end
    end

    context 'when setting a String' do
      subject { described_class.new(nil) }

      before :each do
        subject.data = '<vnstat />'
      end

      it 'stores the XML fragment in #data' do
        expect(subject.data).to be_a Nokogiri::XML::Document
      end
    end
  end

  describe '#version' do
    it 'returns the version attribute value from the vnstat element' do
      expect(subject.version).to eq '1.23'
    end
  end

  describe '#xml_version' do
    it 'returns the xmlversion attribute value from the vnstat element' do
      expect(subject.xml_version).to eq '1'
    end
  end
end
