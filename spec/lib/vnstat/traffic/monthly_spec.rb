describe Vnstat::Traffic::Monthly do
  let :interface do
    data = <<-XML
      <vnstat version="1.12" xmlversion="1">
        <interface id="eth0">
          <traffic>
            <months>
              <month id="0"><date><year>2015</year><month>01</month></date><rx>1000</rx><tx>2000</tx></month>
              <month id="1"><date><year>2015</year><month>02</month></date><rx>3000</rx><tx>4000</tx></month>
            </months>
          </traffic>
        </interface>
      </vnstat>
    XML
    Vnstat::Interface.new('eth0', data)
  end

  subject { described_class.new(interface) }

  it 'includes Enumerable' do
    expect(described_class).to include Enumerable
  end

  describe '#[]' do
    it 'returns a Vntat::Result::Month' do
      expect(subject[2015, 2]).to be_a Vnstat::Result::Month
    end
  end

  describe '#each' do
    it 'yields successively with Vnstat::Result::Month for all months' do
      expect { |block| subject.each(&block) }
        .to yield_successive_args(subject[2015, 1], subject[2015, 2])
    end
  end

  describe '#to_a' do
    it 'contains Vnstat::Result::Month for all months' do
      expect(subject.to_a).to match_array [subject[2015, 1], subject[2015, 2]]
    end
  end
end
