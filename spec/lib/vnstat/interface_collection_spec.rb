# frozen_string_literal: true

describe Vnstat::InterfaceCollection do
  let :data do
    <<-XML
      <vnstat version="0.00" xmlversion="1">
        <interface id="eth0"></interface>
        <interface id="wlan0"></interface>
      </vnstat>
    XML
  end

  subject { described_class.new(data) }

  it { is_expected.to be_a Vnstat::Document }

  describe '.open' do
    it 'calls .new' do
      allow(described_class).to receive(:load_data).and_return('test data')

      expect(described_class).to receive(:new).with('test data')

      described_class.open
    end

    it 'calls .load_data' do
      expect(described_class)
        .to receive(:load_data)
        .and_return('<vnstat xmlversion="1" />')

      described_class.open
    end
  end

  describe '.load_data' do
    it 'calls Vnstat::Utils.call_executable' do
      expect(Vnstat::Utils).to receive(:call_executable).with('--xml')

      described_class.load_data
    end

    it 'returns result of Vnstat::Utils.call_executable' do
      allow(Vnstat::Utils).to receive(:call_executable).with(any_args)
                                                       .and_return('test')

      expect(described_class.load_data).to eq 'test'
    end
  end

  describe '#ids' do
    it 'returns interface names from v1 data' do
      expect(subject.ids).to eq %w[eth0 wlan0]
    end

    it 'returns interface names from v2 data' do
      data = <<-XML
        <vnstat version="0.00" xmlversion="2">
          <interface name="eth0"></interface>
          <interface name="wlan0"></interface>
        </vnstat>
      XML

      collection = described_class.new(data)

      expect(collection.ids).to eq %w[eth0 wlan0]
    end
  end

  describe '#[]' do
    context 'when existing interface given' do
      context 'with String argument' do
        it 'returns Vnstat::Interface' do
          expect(subject['eth0']).to be_a Vnstat::Interface
        end

        it 'returns object with id matching the given argument' do
          expect(subject['eth0'].id).to eq 'eth0'
        end
      end

      context 'with symbolic argument' do
        it 'returns Vnstat::Interface' do
          expect(subject[:eth0]).to be_a Vnstat::Interface
        end

        it 'returns object with id matching the given argument' do
          expect(subject[:eth0].id).to eq 'eth0'
        end
      end
    end

    context 'when non-existing interface given' do
      it 'raises Vnstat::UnknownInterface' do
        expect { subject['eth1'] }.to raise_error(Vnstat::UnknownInterface)
      end
    end
  end

  describe '#create' do
    it 'calls Vnstat::Utils.call_executable_returning_status' do
      expect(Vnstat::Utils).to receive(:call_executable_returning_status)
        .with('--create', '-i', 'test').and_return(false)

      subject.create('test')
    end

    context 'when Vnstat::Utils.call_executable_returning_status ' \
            'returns true' do
      before :each do
        allow(Vnstat::Utils).to receive(:call_executable_returning_status)
          .and_return(true)
      end

      it 'calls #[] with first arg' do
        allow(subject).to receive(:reload)

        expect(subject).to receive(:[]).with('test')

        subject.create('test')
      end

      it 'returns result of #[] with first arg' do
        allow(subject).to receive(:reload)

        allow(subject).to receive(:[]).and_return('test')

        expect(subject.create('eth1')).to eq 'test'
      end

      it 'calls #reload' do
        allow(subject).to receive(:[]).with('test')

        expect(subject).to receive(:reload)

        subject.create('test')
      end
    end

    context 'when Vnstat::Utils.call_executable_returning_status ' \
            'returns false' do
      before :each do
        allow(Vnstat::Utils).to receive(:call_executable_returning_status)
          .and_return(false)
      end

      it 'returns nil' do
        expect(subject.create('test')).to be nil
      end
    end
  end

  describe '#reload' do
    before :each do
      allow(described_class).to receive(:load_data).and_return('<test />')
    end

    it 'sets #data using .load_data' do
      expect(subject).to receive(:data=).with('<test />')

      subject.reload
    end

    it 'returns self' do
      expect(subject.reload).to eq subject
    end
  end

  describe '#rebuild' do
    before :each do
      allow(described_class).to receive(:load_data).and_return('<test />')
    end

    context 'when Vnstat::Utils.call_executable_returning_status ' \
            'returns true' do
      before :each do
        allow(Vnstat::Utils)
          .to receive(:call_executable_returning_status)
          .with('--rebuildtotal').and_return(true)
      end

      it 'returns self' do
        expect(subject.rebuild).to eq subject
      end

      it 'calls #reload' do
        expect(subject).to receive(:reload)

        subject.rebuild
      end
    end

    context 'when Vnstat::Utils.call_executable_returning_status ' \
            'returns false' do
      before :each do
        allow(Vnstat::Utils)
          .to receive(:call_executable_returning_status)
          .with('--rebuildtotal').and_return(false)
      end

      it 'returns self' do
        expect(subject.rebuild).to eq subject
      end

      it 'does not call #reload' do
        expect(subject).not_to receive(:reload)

        subject.rebuild
      end
    end
  end
end
