describe Vnstat::Result::Day do
  describe '.extract_from_xml_element' do
    let :element do
      data = <<-XML
        <day id="0">
          <date><year>2015</year><month>7</month><day>14</day></date>
          <rx>1000</rx><tx>2000</tx>
        </day>
      XML
      Nokogiri::XML.parse(data).xpath('day')
    end

    subject do
      described_class.extract_from_xml_element(element)
    end

    it { is_expected.to be_a described_class }

    it 'initializes with the correct #date' do
      expect(subject.date).to eq Date.new(2015, 7, 14)
    end

    it 'initializes with the correct #bytes_received' do
      expect(subject.bytes_received).to eq 1000 * 1024
    end

    it 'initializes with the correct #bytes_sent' do
      expect(subject.bytes_sent).to eq 2000 * 1024
    end
  end

  include_examples 'date delegation' do
    subject { described_class.new(Date.today, 0, 0) }
  end
end
