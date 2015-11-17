describe Vnstat::Traffic::Hourly do
  let :interface do
    data = <<-XML
      <vnstat version="1.12" xmlversion="1">
        <interface id="eth0">
          <traffic>
            <hours>
              <hour id="19">
                <date><year>2015</year><month>10</month><day>21</day></date>
                <rx>1000</rx><tx>2000</tx>
              </hour>
              <hour id="20">
                <date><year>2015</year><month>10</month><day>21</day></date>
                <rx>3000</rx><tx>4000</tx>
              </hour>
            </hours>
          </traffic>
        </interface>
      </vnstat>
    XML
    Vnstat::Interface.new('eth0', data)
  end

  subject { described_class.new(interface) }

  include_examples 'traffic collection'

  describe '#[]' do
    context 'with 1 argument' do
      it 'fails' do
        expect { subject[nil] }.to(
          raise_error(ArgumentError, 'wrong number of arguments (1 for 2 or 4)')
        )
      end
    end

    context 'with 2 arguments' do
      let(:date) { Date.new(2015, 10, 21) }
      let(:hour) { 20 }

      context 'for existing entry' do
        it 'returns a Vnstat::Result::Day' do
          expect(subject[date, hour]).to be_a Vnstat::Result::Hour
        end

        it 'returns an object with the expected #date' do
          expect(subject[date, hour].date).to eq date
        end

        it 'returns an object with the expected #hour' do
          expect(subject[date, hour].hour).to eq hour
        end

        it 'returns an object with the expected #bytes_received' do
          expect(subject[date, hour].bytes_received).to eq 3000 * 1024
        end

        it 'returns an object with the expected #bytes_sent' do
          expect(subject[date, hour].bytes_sent).to eq 4000 * 1024
        end
      end

      context 'for entry with non-existing date' do
        it 'returns nil' do
          expect(subject[Date.new(2015, 10, 20), 19]).to be nil
        end
      end

      context 'for entry with non-existing hour' do
        it 'returns nil' do
          expect(subject[date, 0]).to be nil
        end
      end

      context 'for entry with non-existing date and hour' do
        it 'returns nil' do
          expect(subject[Date.new(2015, 10, 20), 0]).to be nil
        end
      end
    end

    context 'with 3 arguments' do
      it 'fails' do
        expect { subject[nil, nil, nil] }.to(
          raise_error(ArgumentError, 'wrong number of arguments (3 for 2 or 4)')
        )
      end
    end

    context 'with 4 arguments' do
      let(:date_args) { [2015, 10, 21] }
      let(:hour) { 20 }

      context 'for existing entry' do
        it 'returns a Vnstat::Result::Day' do
          expect(subject[*date_args, hour]).to be_a Vnstat::Result::Hour
        end

        it 'returns an object with the expected #date' do
          expect(subject[*date_args, hour].date).to eq Date.new(*date_args)
        end

        it 'returns an object with the expected #hour' do
          expect(subject[*date_args, hour].hour).to eq hour
        end

        it 'returns an object with the expected #bytes_received' do
          expect(subject[*date_args, hour].bytes_received).to eq 3000 * 1024
        end

        it 'returns an object with the expected #bytes_sent' do
          expect(subject[*date_args, hour].bytes_sent).to eq 4000 * 1024
        end
      end

      context 'for entry with non-existing date' do
        it 'returns nil' do
          expect(subject[2015, 10, 20, 19]).to be nil
        end
      end

      context 'for entry with non-existing hour' do
        it 'returns nil' do
          expect(subject[*date_args, 0]).to be nil
        end
      end

      context 'for entry with non-existing date and hour' do
        it 'returns nil' do
          expect(subject[2015, 10, 20, 0]).to be nil
        end
      end
    end

    context 'with 5 or more arguments' do
      it 'fails' do
        expect { subject[nil, nil, nil, nil, nil] }.to(
          raise_error(ArgumentError, 'wrong number of arguments (5 for 2 or 4)')
        )
      end
    end
  end

  describe '#each' do
    it 'yields successively with Vnstat::Result::Hour as argument' do
      first_result = subject[2015, 10, 21, 19]
      second_result = subject[2015, 10, 21, 20]

      expect { |block| subject.each(&block) }
        .to yield_successive_args(first_result, second_result)
    end
  end
end
