describe Vnstat::Utils do
  let(:executable_path) { '/any/path' }

  before :each do
    Vnstat.config.executable_path = executable_path
  end

  describe '.system_call' do
    pending
  end

  describe '.system_call_returning_status' do
    it 'calls .system_call' do
      expect(described_class).to receive(:system_call).with('test')

      described_class.system_call_returning_status('test')
    end

    context 'when .system_call yields' do
      before :each do
        allow(described_class).to receive(:system_call).and_yield
      end

      it 'returns false' do
        expect(described_class.system_call_returning_status('test')).to be false
      end
    end

    context 'when .system_call does not yield' do
      before :each do
        allow(described_class).to receive(:system_call).and_return(nil)
      end

      it 'returns true' do
        expect(described_class.system_call_returning_status('test')).to be true
      end
    end
  end

  describe '.call_executable' do
    let(:block) { Proc.new {} }

    it 'calls .system_call using vnstat executable' do
      expect(described_class).to receive(:system_call)
        .with(executable_path, 'test', &block)

      described_class.call_executable('test', &block)
    end

    it 'returns the result returned by .system_call' do
      allow(described_class).to receive(:system_call).and_return('result')

      expect(described_class.call_executable('test')).to eq 'result'
    end
  end

  describe '.call_executable_returning_status' do
    it 'calls .system_call_returning_status using vnstat executable' do
      expect(described_class).to receive(:system_call_returning_status)
        .with(executable_path, 'test')

      described_class.call_executable_returning_status('test')
    end

    it 'returns the result returned by .system_call_returning_status' do
      allow(described_class).to receive(:system_call_returning_status)
        .and_return(true)

      expect(described_class.call_executable_returning_status('test'))
        .to be true
    end
  end
end
