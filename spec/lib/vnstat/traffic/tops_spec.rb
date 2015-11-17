describe Vnstat::Traffic::Tops do
  let :interface do
    data = <<-XML
      <vnstat version="1.12" xmlversion="1">
        <interface id="eth0">
          <traffic>
            <tops>
              <top id="0">
                <date><year>2015</year><month>01</month><day>01</day></date>
                <time><hour>12</hour><minute>34</minute></time>
                <rx>1000</rx><tx>2000</tx>
              </top>
              <top id="1">
                <date><year>2015</year><month>02</month><day>02</day></date>
                <time><hour>23</hour><minute>45</minute></time>
                <rx>3000</rx><tx>4000</tx>
              </top>
            </tops>
          </traffic>
        </interface>
      </vnstat>
    XML
    Vnstat::Interface.new('eth0', data)
  end

  subject { described_class.new(interface) }

  include_examples 'traffic collection'

  describe '#[]' do
    it 'returns the Vnstat::Result::Minute at the specified index' do
      expect(subject[0]).to be_a Vnstat::Result::Minute
    end
  end

  describe '#each' do
    it 'yields successively with Vnstat::Result::Minute for all top entries' do
      expect { |block| subject.each(&block) }
        .to yield_successive_args(subject[0], subject[1])
    end
  end

  describe '#to_a' do
    it 'contains Vnstat::Result::Month for all months' do
      expect(subject.to_a).to match_array [subject[0], subject[1]]
    end
  end
end
