# frozen_string_literal: true

describe Vnstat do
  describe '.config' do
    subject { described_class.config }

    it { is_expected.to be_a Vnstat::Configuration }

    it 'is only instantiated once' do
      expect(subject).to be described_class.config
    end
  end

  describe '.configure' do
    it 'returns .config' do
      expect(described_class.configure { 'test' }).to eq described_class.config
    end

    context 'when no block given' do
      it 'raises' do
        expect { described_class.configure }.to raise_error LocalJumpError
      end
    end

    context 'when block given' do
      it 'yields once' do
        expect { |block| described_class.configure(&block) }
          .to yield_control.exactly(1).times
      end

      it 'yields with configuration' do
        expect { |block| described_class.configure(&block) }
          .to yield_with_args(described_class.config)
      end
    end
  end

  describe '.interfaces' do
    it 'calls Vnstat::InterfaceCollection.open' do
      expect(Vnstat::InterfaceCollection).to receive(:open)

      described_class.interfaces
    end
  end

  describe '.[]' do
    it 'delegates to #interfaces' do
      allow(described_class).to receive(:interfaces) do
        { 'eth0' => 'test' }
      end

      expect(described_class['eth0']).to eq 'test'
    end
  end

  describe '.cli_version' do
    it 'calls Utils.call_executable with -v argument' do
      expect(Vnstat::Utils).to receive(:call_executable).with('-v')

      described_class.cli_version
    end
  end

  describe '.version' do
    it 'calls Vnstat.cli_version' do
      expect(Vnstat).to receive(:cli_version)

      described_class.version
    end
  end
end
