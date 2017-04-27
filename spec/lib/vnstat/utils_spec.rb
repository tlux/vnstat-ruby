describe Vnstat::Utils do
  let(:executable_path) { '/any/path' }

  before :each do
    allow(Vnstat.config)
      .to receive(:executable_path)
      .and_return(executable_path)
  end

  describe '.system_call' do
    it 'calls Vnstat::SystemCall.call' do
      expect(Vnstat::SystemCall).to receive(:call).with('test', 'test2') do
        double(success?: true, success_result: 'success')
      end

      described_class.system_call('test', 'test2')
    end

    context 'when Vnstat::SystemCall#success? is true' do
      let(:system_call) { Vnstat::SystemCall.new('test') }

      before :each do
        allow(system_call).to receive(:success?).and_return(true)
        allow(system_call).to receive(:success_result).and_return('success')

        allow(Vnstat::SystemCall).to receive(:call).with('test')
          .and_return(system_call)
      end

      it 'returns Vnstat::SystemCall#success_result' do
        expect(described_class.system_call('test')).to eq 'success'
      end
    end

    context 'when Vnstat::SystemCall#success? is false' do
      let(:system_call) { Vnstat::SystemCall.new('test') }

      before :each do
        allow(system_call).to receive(:success?).and_return(false)
        allow(system_call).to receive(:error_result).and_return('error')

        allow(Vnstat::SystemCall).to receive(:call).with('test')
          .and_return(system_call)
      end

      context 'without block given' do
        it 'returns Vnstat::SystemCall#error_result' do
          expect(described_class.system_call('test')).to eq 'error'
        end
      end

      context 'with block given' do
        it 'yields with Vnstat::SystemCall#error_result' do
          expect { |block| described_class.system_call('test', &block) }
            .to yield_with_args(system_call.error_result)
        end

        it 'returns block result' do
          expect(described_class.system_call('test') { 'failed' })
            .to eq 'failed'
        end
      end
    end
  end

  describe '.system_call_returning_status' do
    it 'calls Vnstat::SystemCall.call' do
      expect(Vnstat::SystemCall).to receive(:call).with('test')
        .and_return(double(success?: true))

      described_class.system_call_returning_status('test')
    end

    context 'when Vnstat::SystemCall#success? is true' do
      before :each do
        allow_any_instance_of(Vnstat::SystemCall)
          .to receive(:success?).and_return(true)
      end

      it 'returns true' do
        expect(described_class.system_call_returning_status('test')).to be true
      end
    end

    context 'when vnstat::SystemCall#success? is false' do
      before :each do
        allow_any_instance_of(Vnstat::SystemCall)
          .to receive(:success?).and_return(false)
      end

      it 'returns false' do
        expect(described_class.system_call_returning_status('test')).to be false
      end
    end
  end

  describe '.call_executable' do
    let(:block) { proc {} }

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
