describe Vnstat::Result::Month do
  describe '.extract_from_xml_element' do
    let! :element do
      data = <<-XML
        <month id="0">
          <date><year>2015</year><month>9</month></date>
          <rx>1000</rx><tx>2000</tx>
        </month>
      XML
      Nokogiri::XML.parse(data).xpath('month')
    end

    subject do
      described_class.extract_from_xml_element(element)
    end

    it { is_expected.to be_a described_class }

    it 'initializes with the correct #year' do
      expect(subject.year).to eq 2015
    end

    it 'initializes with the correct #month' do
      expect(subject.month).to eq 9
    end

    it 'initializes with the correct #bytes_received' do
      expect(subject.bytes_received).to eq 1000 * 1024
    end

    it 'initializes with the correct #bytes_sent' do
      expect(subject.bytes_sent).to eq 2000 * 1024
    end
  end
end
