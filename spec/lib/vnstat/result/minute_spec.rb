describe Vnstat::Result::Minute do
  it 'includes Comparable' do
    expect(described_class).to include Comparable
  end

  describe '.extract_from_xml_element' do
    let :element do
      data = <<-XML
        <top id="0">
          <date><year>2015</year><month>2</month><day>3</day></date>
          <time><hour>12</hour><minute>34</minute></time>
          <rx>1000</rx><tx>2000</tx>
        </top>
      XML
      Nokogiri::XML.parse(data).xpath('top')
    end

    subject do
      described_class.extract_from_xml_element(element)
    end

    it { is_expected.to be_a described_class }

    it 'initializes with the correct #time with the system time zone' do
      time = DateTime.new(2015, 2, 3, 12, 34, 0o0, DateTime.now.offset)

      expect(subject.time).to eq time
    end

    it 'initializes with the correct #date' do
      expect(subject.date).to eq Date.new(2015, 2, 3)
    end

    it 'initializes with the correct #hour' do
      expect(subject.hour).to eq 12
    end

    it 'initialized with the correct #minute' do
      expect(subject.minute).to eq 34
    end

    it 'initializes with the correct #bytes_received' do
      expect(subject.bytes_received).to eq 1000 * 1024
    end

    it 'initializes with the correct #bytes_sent' do
      expect(subject.bytes_sent).to eq 2000 * 1024
    end
  end

  include_examples 'date delegation' do
    subject { described_class.new(DateTime.now, 0, 0) }
  end
end
