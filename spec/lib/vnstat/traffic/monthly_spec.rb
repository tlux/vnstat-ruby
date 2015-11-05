describe Vnstat::Traffic::Monthly do
  subject do
    data = <<-XML
      <vnstat version="1.12" xmlversion="1">
        <interface id="eth0">
          <traffic>
            <months>
              <month id="0"><date><year>2015</year><month>1</month></date><rx>1000</rx><tx>2000</tx></month>
              <month id="1"><date><year>2015</year><month>2</month></date><rx>3000</rx><tx>4000</tx></month>
            </months>
          </traffic>
        </interface>
      </vnstat>
    XML
    interface = Vnstat::Interface.new('eth0', data)
    described_class.new(interface)
  end

  it 'includes Enumerable' do
    expect(described_class).to include Enumerable
  end

  describe '#[]' do
    pending
  end

  describe '#each' do
    it 'yields successively with Vnstat::Result::Hour as argument' do
      first_result = subject[2015, 1]
      second_result = subject[2015, 2]

      expect { |block| subject.each(&block) }
        .to yield_successive_args(first_result, second_result)
    end
  end
end
