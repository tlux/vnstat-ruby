describe Vnstat::Interface do
  let! :document do
    data = <<-XML
      <vnstat version="1.12" xmlversion="1">
        <interface id="eth0">
          <id>eth0-test</id>
          <nick>Ethernet</nick>
          <created><date><year>2015</year><month>10</month><day>21</day></date></created>
          <updated><date><year>2015</year><month>10</month><day>21</day></date><time><hour>22</hour><minute>58</minute></time></updated>
          <traffic>
            <total><rx>40732</rx><tx>7978</tx></total>
            <days>
              <day id="0"><date><year>2015</year><month>10</month><day>21</day></date><rx>40732</rx><tx>7978</tx></day>
            </days>
            <months>
              <month id="0"><date><year>2015</year><month>10</month></date><rx>40732</rx><tx>7978</tx></month>
            </months>
            <tops>
            </tops>
            <hours>
              <hour id="19"><date><year>2015</year><month>10</month><day>21</day></date><rx>6163</rx><tx>771</tx></hour>
              <hour id="20"><date><year>2015</year><month>10</month><day>21</day></date><rx>18367</rx><tx>3423</tx></hour>
            </hours>
          </traffic>
        </interface>
      </vnstat>
    XML
    Vnstat::Document.new(data)
  end

  subject { described_class.new(document, 'eth0') }

  describe '#id' do
    it 'returns id from the interface node' do
      expect(subject.id).to eq 'eth0'
    end
  end

  describe '#name' do
    it 'returns value from the nick node' do
      expect(subject.name).to eq 'Ethernet'
    end
  end

  describe '#created_on' do
    it 'returns the Date from the created node' do
      date = Date.new(2015, 10, 21)
      expect(subject.created_on).to eq date
    end
  end

  describe '#updated_at' do
    it 'returns the DateTime from the updated node' do
      datetime = DateTime.new(2015, 10, 21, 22, 58)
      expect(subject.updated_at).to eq datetime
    end
  end

  describe '#total' do
    it 'returns a Vnstat::Traffic' do
      expect(subject.total).to be_a Vnstat::Traffic
    end
  end

  describe '#days' do
    pending
  end

  describe '#months' do
    pending
  end

  describe '#hours' do
    pending
  end

  describe '#tops' do
    pending
  end
end
