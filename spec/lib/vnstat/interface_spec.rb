# frozen_string_literal: true

describe Vnstat::Interface do
  let :data do
    <<-XML
      <vnstat version="1.12" xmlversion="1">
        <interface id="eth0">
          <id>eth0-test</id>
          <nick>Ethernet</nick>
          <created>
            <date><year>2015</year><month>10</month><day>21</day></date>
          </created>
          <updated>
            <date><year>2015</year><month>10</month><day>21</day></date>
            <time><hour>22</hour><minute>58</minute></time>
          </updated>
          <traffic>
            <total><rx>1000</rx><tx>2000</tx></total>
            <days>
              <day id="0">
                <date><year>2015</year><month>1</month><day>1</day></date>
                <rx>1000</rx><tx>2000</tx>
              </day>
              <day id="1">
                <date><year>2015</year><month>1</month><day>2</day></date>
                <rx>3000</rx><tx>4000</tx>
              </day>
            </days>
            <months>
              <month id="0">
                <date><year>2015</year><month>1</month></date>
                <rx>1000</rx><tx>2000</tx>
              </month>
              <month id="1">
                <date><year>2015</year><month>2</month></date>
                <rx>3000</rx><tx>4000</tx>
              </month>
            </months>
            <tops>
              <top id="0">
                <date><year>2015</year><month>10</month><day>22</day></date>
                <time><hour>00</hour><minute>00</minute></time>
                <rx>1000</rx><tx>2000</tx>
              </top>
              <top id="1">
                <date><year>2015</year><month>10</month><day>21</day></date>
                <time><hour>19</hour><minute>53</minute></time>
                <rx>3000</rx><tx>4000</tx>
              </top>
            </tops>
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
  end

  subject { described_class.new('eth0', data) }

  it { is_expected.to be_a Vnstat::Document }

  describe '.open' do
    it 'calls .new forwarding the first argument' do
      allow(described_class).to receive(:load_data).with('test')
        .and_return('test data')

      expect(described_class).to receive(:new).with('test', 'test data')

      described_class.open('test')
    end

    it 'calls .load_data forwarding the argument' do
      expect(described_class).to receive(:load_data).with('test')
        .and_return('<vnstat />')

      described_class.open('test')
    end
  end

  describe '.load_data' do
    it 'calls Vnstat::Utils.call_executable' do
      expect(Vnstat::Utils).to receive(:call_executable)
        .with('-i', 'test', '--xml')

      described_class.load_data('test')
    end

    it 'returns result of Vnstat::Utils.call_executable' do
      allow(Vnstat::Utils).to receive(:call_executable).with(any_args)
        .and_return('test')

      expect(described_class.load_data('eth0')).to eq 'test'
    end
  end

  describe '#id' do
    it 'returns id from the interface node' do
      expect(subject.id).to eq 'eth0'
    end
  end

  %w[nick name].each do |method_name|
    describe "##{method_name}" do
      it 'returns value from the nick node' do
        expect(subject.public_send(method_name)).to eq 'Ethernet'
      end
    end

    describe "##{method_name}=" do
      context 'when nickname can be set by vnstat' do
        before :each do
          allow(Vnstat::Utils).to receive(:call_executable_returning_status)
            .and_return(true)
        end

        it 'sets #nick to argument' do
          expect { subject.nick = 'test' }.to change { subject.nick }.to('test')
        end
      end

      context 'when nickname cannot be set by vnstat' do
        before :each do
          allow(Vnstat::Utils).to receive(:call_executable_returning_status)
            .and_return(false)
        end

        it 'raises Vnstat::Error' do
          expect { subject.nick = 'test' }.to raise_error(
            Vnstat::Error, 'Unable to set nickname for interface (eth0). ' \
                           'Please make sure the vnstat daemon is not ' \
                           'running while performing this operation.'
          )
        end
      end
    end
  end

  describe '#created_on' do
    it 'returns the Date from the created node' do
      date = Date.new(2015, 10, 21)
      expect(subject.created_on).to eq date
    end
  end

  describe '#updated_at' do
    it 'returns the Time from the updated node in the correct time zone' do
      offset = Time.now.strftime('%:z')
      time = Time.new(2015, 10, 21, 22, 58, 0o0, offset)

      expect(subject.updated_at).to eq time
    end
  end

  describe '#total' do
    it 'returns a Vnstat::Result' do
      expect(subject.total).to be_a Vnstat::Result
    end

    it 'returns a result with the correct bytes received' do
      expect(subject.total.bytes_received).to eq(1000 * 1024)
    end

    it 'returns a result with the correct bytes sent' do
      expect(subject.total.bytes_sent).to eq(2000 * 1024)
    end
  end

  describe '#hours' do
    it 'returns a Vnstat::Traffic::Hourly' do
      expect(subject.hours).to be_a Vnstat::Traffic::Hourly
    end

    it 'stores subject in Vnstat::Traffic::Hourly#interface' do
      expect(subject.hours.interface).to eq subject
    end
  end

  describe '#days' do
    it 'returns a Vnstat::Traffic::Daily' do
      expect(subject.days).to be_a Vnstat::Traffic::Daily
    end

    it 'stores subject in Vnstat::Traffic::Daily#interface' do
      expect(subject.days.interface).to eq subject
    end
  end

  describe '#months' do
    it 'returns a Vnstat::Traffic::Monthly' do
      expect(subject.months).to be_a Vnstat::Traffic::Monthly
    end

    it 'stores subject in Vnstat::Traffic::Monthly#interface' do
      expect(subject.months.interface).to eq subject
    end
  end

  describe '#tops' do
    it 'returns a Vnstat::Traffic::Tops' do
      expect(subject.tops).to be_a Vnstat::Traffic::Tops
    end

    it 'stores subject in Vnstat::Traffic::Tops#interface' do
      expect(subject.tops.interface).to eq subject
    end
  end

  describe '#reload' do
    let :reloaded_data do
      <<-XML
        <vnstat version="1.12" xmlversion="1">
          <interface id="eth0">
            <id>eth0</id>
            <nick>New Ethernet</nick>
          </interface>
        </vnstat>
      XML
    end

    before :each do
      allow(described_class).to receive(:load_data).and_return('<test />')
    end

    it 'returns self' do
      expect(subject.reload).to eq subject
    end

    it 'calls .load_data with #id as argument' do
      expect(described_class).to receive(:load_data).with('eth0')
        .and_return(reloaded_data)

      subject.reload
    end

    it 'calls #data= with the result from .load_data' do
      allow(described_class).to receive(:load_data).and_return('<vnstat />')

      expect(subject).to receive(:data=).with('<vnstat />')

      subject.reload
    end

    it 'resets #nick from reloaded data' do
      allow(described_class).to receive(:load_data).with('eth0')
        .and_return(reloaded_data)

      expect { subject.reload }
        .to change { subject.nick }.from('Ethernet').to('New Ethernet')
    end
  end

  describe '#delete' do
    it 'calls Vnstat::Utils.call_executable_returning_status' do
      expect(Vnstat::Utils).to receive(:call_executable_returning_status)
        .with('--delete', '-i', subject.id)

      subject.delete
    end

    [true, false].each do |expected|
      context 'when Vnstat::Utils.call_executable_returning_status ' \
              "returns #{expected}" do
        before :each do
          allow(Vnstat::Utils).to receive(:call_executable_returning_status)
            .with(any_args).and_return(expected)
        end

        it 'returns true' do
          expect(subject.delete).to be expected
        end
      end
    end
  end

  describe '#reset' do
    it 'calls Vnstat::Utils.call_executable_returning_status' do
      expect(Vnstat::Utils).to receive(:call_executable_returning_status)
        .with('--reset', '-i', subject.id)

      subject.reset
    end

    context 'when Vnstat::Utils.call_executable_returning_status ' \
            'returns true' do
      before :each do
        allow(Vnstat::Utils).to receive(:call_executable_returning_status)
          .with(any_args).and_return(true)
      end

      it 'returns self' do
        allow(subject).to receive(:reload)

        expect(subject.reset).to eq subject
      end

      it 'calls #reload' do
        expect(subject).to receive(:reload)

        subject.reset
      end
    end

    context 'when Vnstat::Utils.call_executable_returning_status ' \
            'returns false' do
      before :each do
        allow(Vnstat::Utils).to receive(:call_executable_returning_status)
          .with(any_args).and_return(false)
      end

      it 'returns self' do
        expect(subject.reset).to eq subject
      end

      it 'does not call #reload' do
        expect(subject).not_to receive(:reload)

        subject.reset
      end
    end
  end
end
