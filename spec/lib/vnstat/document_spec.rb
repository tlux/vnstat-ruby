describe Vnstat::Document do
  subject do
    described_class.new('<vnstat version="1.23" xmlversion="1"></vnstat>')
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
