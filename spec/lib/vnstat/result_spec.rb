describe Vnstat::Result do
  it 'includes Comparable' do
    expect(described_class).to include Comparable
  end

  describe '.extract_from_xml_element' do
    let :element do
      data = <<-XML
        <total>
          <rx>1000</rx><tx>2000</tx>
        </total>
      XML
      Nokogiri::XML.parse(data).xpath('total')
    end

    subject { described_class.extract_from_xml_element(element) }

    it { is_expected.to be_a described_class }

    it 'initializes with the correct #bytes_received' do
      expect(subject.bytes_received).to eq 1000 * 1024
    end

    it 'initializes with the correct #bytes_sent' do
      expect(subject.bytes_sent).to eq 2000 * 1024
    end
  end

  describe '#initialize' do
    subject { described_class.new(1000, 2000) }

    it 'stores the first argument in #bytes_received' do
      expect(subject.bytes_received).to eq 1000
    end

    it 'stores the second argument in #bytes_sent' do
      expect(subject.bytes_sent).to eq 2000
    end
  end

  describe '#bytes_transmitted' do
    subject { described_class.new(1000, 2000) }

    it 'returns sum of #bytes_received and #bytes_sent' do
      expect(subject.bytes_transmitted).to eq 3000
    end
  end

  describe '#<=>' do
    subject { described_class.new(1000, 2000) }

    context 'when argument does not respond to :bytes_transmitted' do
      let(:other) { double }

      it 'returns nil' do
        expect(subject <=> other).to be nil
      end
    end

    context 'when argument responds to :bytes_transmitted' do
      context 'with other value being greater' do
        let(:other) { double(bytes_transmitted: 4000) }

        it 'returns -1' do
          expect(subject <=> other).to eq -1
        end
      end

      context 'with other value being equal' do
        let(:other) { double(bytes_transmitted: 3000) }

        it 'returns 0' do
          expect(subject <=> other).to eq 0
        end
      end

      context 'with other value being lower' do
        let(:other) { double(bytes_transmitted: 2000) }

        it 'returns 1' do
          expect(subject <=> other).to eq 1
        end
      end
    end
  end
end
