describe Vnstat::Traffic::Daily do
  subject do
    data = <<-XML
      <vnstat version="1.12" xmlversion="1">
        <interface id="eth0">
          <traffic>
            <days>
              <day id="0"><date><year>2015</year><month>1</month><day>1</day></date><rx>1000</rx><tx>2000</tx></day>
              <day id="1"><date><year>2015</year><month>1</month><day>2</day></date><rx>3000</rx><tx>4000</tx></day>
            </days>
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
    context 'with 1 argument' do
      context 'for existing entry' do
        let(:date) { Date.new(2015, 1, 1) }

        it 'returns a Vnstat::Result::Day' do
          expect(subject[date]).to be_a Vnstat::Result::Day
        end

        it 'returns an object with the expected #date' do
          expect(subject[date].date).to eq date
        end

        it 'returns an object with the expected #bytes_received' do
          expect(subject[date].bytes_received).to eq 1000 * 1024
        end

        it 'returns an object with the expected #bytes_sent' do
          expect(subject[date].bytes_sent).to eq 2000 * 1024
        end
      end

      context 'for not-existing entry' do
        it 'returns nil' do
          expect(subject[Date.new(2015, 1, 3)]).to be nil
        end
      end
    end

    context 'with 2 arguments' do
      it 'fails' do
        expect { subject[nil, nil] }.to(
          raise_error(ArgumentError, 'wrong number of arguments (2 for 1 or 3)')
        )
      end
    end

    context 'with 3 arguments' do
      context 'for existing entry' do
        it 'returns a Vnstat::Result::Day' do
          expect(subject[2015, 1, 1]).to be_a Vnstat::Result::Day
        end

        it 'returns an object with the expected #date' do
          expect(subject[2015, 1, 1].date).to eq Date.new(2015, 1, 1)
        end

        it 'returns an object with the expected #bytes_received' do
          expect(subject[2015, 1, 1].bytes_received).to eq 1000 * 1024
        end

        it 'returns an object with the expected #bytes_sent' do
          expect(subject[2015, 1, 1].bytes_sent).to eq 2000 * 1024
        end
      end

      context 'for not-existing entry' do
        it 'returns nil' do
          expect(subject[2015, 1, 3]).to be nil
        end
      end
    end

    context 'with more than 3 arguments' do
      it 'fails' do
        expect { subject[nil, nil, nil, nil] }.to(
          raise_error(ArgumentError, 'wrong number of arguments (4 for 1 or 3)')
        )
      end
    end
  end

  describe '#each' do
    it 'yields successively with Vnstat::Result::Day as argument' do
      first_result = subject[2015, 1, 1]
      second_result = subject[2015, 1, 2]

      expect { |block| subject.each(&block) }
        .to yield_successive_args(first_result, second_result)
    end
  end
end
