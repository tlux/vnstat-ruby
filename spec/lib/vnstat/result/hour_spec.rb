describe Vnstat::Result::Hour do
  it 'includes Comparable' do
    expect(described_class).to include Comparable
  end

  describe '.extract_from_xml_element' do
    let :element do
      data = <<-XML
        <hour id="19">
          <date><year>2015</year><month>10</month><day>21</day></date>
          <rx>1000</rx><tx>2000</tx>
        </hour>
      XML
      Nokogiri::XML.parse(data).xpath('hour')
    end

    subject do
      described_class.extract_from_xml_element(element)
    end

    it { is_expected.to be_a described_class }

    it 'initializes with the correct #date' do
      expect(subject.date).to eq Date.new(2015, 10, 21)
    end

    it 'initializes with the correct #hour' do
      expect(subject.hour).to eq 19
    end

    it 'initializes with the correct #bytes_received' do
      expect(subject.bytes_received).to eq 1000 * 1024
    end

    it 'initializes with the correct #bytes_sent' do
      expect(subject.bytes_sent).to eq 2000 * 1024
    end
  end

  include_examples 'date delegation' do
    subject { described_class.new(Date.today, 12, 0, 0) }
  end
end
