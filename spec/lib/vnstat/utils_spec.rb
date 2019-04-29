# frozen_string_literal: true

describe Vnstat::Utils do
  let(:executable_path) { '/any/path' }

  before :each do
    allow(Vnstat.config)
      .to receive(:executable_path)
      .and_return(executable_path)
  end

  describe '.system_call' do
    let(:args) { double('args') }

    it 'calls SystemCall.call' do
      expect(SystemCall).to receive(:call).with(args) do
        double('result', success?: true, success_result: 'success')
      end

      described_class.system_call(args)
    end

    context 'when SystemCall::Result#success? is true' do
      it 'returns SystemCall::Result#success_result' do
        success_result = double('success result')

        allow(SystemCall).to receive(:call).with(args) do
          double('result', success?: true, success_result: success_result)
        end

        expect(described_class.system_call(args)).to be success_result
      end
    end

    context 'when SystemCall::Result#success? is false' do
      let(:error_result) { double('error result') }

      before do
        allow(SystemCall).to receive(:call).with(args) do
          double('result', success?: false, error_result: error_result)
        end
      end

      it 'returns SystemCall::Result#error_result when no block given' do
        expect(described_class.system_call(args)).to be error_result
      end

      context 'when block given' do
        let(:block_result) { double('block result') }
        let(:block) { proc { block_result } }

        it 'yields SystemCall::Result#error_result as block arg' do
          expect { |block| described_class.system_call(args, &block) }
            .to yield_with_args(error_result)
        end

        it 'returns block result' do
          expect(described_class.system_call(args, &block)).to be block_result
        end
      end
    end
  end

  describe '.system_call_returning_status' do
    let(:args) { double('args') }

    it 'returns true when SystemCall::Result#success? is true' do
      allow(SystemCall).to receive(:call).with(args) do
        double('result', success?: true)
      end

      expect(described_class.system_call_returning_status(args)).to be true
    end

    it 'returns false when SystemCall::Result#success? is false' do
      allow(SystemCall).to receive(:call).with(args) do
        double('result', success?: false)
      end

      expect(described_class.system_call_returning_status(args)).to be false
    end
  end

  describe '.call_executable' do
    it 'calls and returns result of .system_call with Vnstat executable' do
      block = proc {}
      args = double('args')
      result = double('result')

      expect(described_class)
        .to receive(:system_call)
        .with(executable_path, *args, &block)
        .and_return(result)

      expect(described_class.call_executable(args)).to eq result
    end
  end

  describe '.call_executable_returning_status' do
    it 'calls and returns result of .system_call_returning_status with ' \
       'Vnstat executable' do
      args = double('args')
      result = double('result')

      expect(described_class)
        .to receive(:system_call_returning_status)
        .with(executable_path, *args)
        .and_return(result)

      expect(described_class.call_executable_returning_status(args))
        .to eq result
    end
  end
end
