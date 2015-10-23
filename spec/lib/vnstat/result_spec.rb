describe Vnstat::Result do
  describe '.extract_from_xml_element' do
    let! :element do
      data = <<-XML
        <total>
          <rx>1000</rx><tx>2000</tx>
        </total>
      XML
      Nokogiri::XML.parse(data).xpath('total')
    end

    subject do
      described_class.extract_from_xml_element(element)
    end

    it { is_expected.to be_a described_class }

    it 'initializes with the correct #bytes_received' do
      expect(subject.bytes_received).to eq 1000 * 1024
    end

    it 'initializes with the correct #bytes_sent' do
      expect(subject.bytes_sent).to eq 2000 * 1024
    end
  end
end
