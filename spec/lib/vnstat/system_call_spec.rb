describe Vnstat::SystemCall do
  let(:args) { ['test', 'test2', 'test3'] }

  describe '#initialize' do
    context 'when arguments are anything' do
      subject { described_class.new(*args) }

      it 'stores args in #args' do
        expect(subject.args).to eq args
      end
    end

    context 'when first argument is an Array' do
      subject { described_class.new(args) }

      it 'stores args in #args' do
        expect(subject.args).to eq args
      end
    end
  end

  describe '.call' do
    it 'forwards args to .new' do
      expect(described_class).to receive(:new).with('test').and_call_original

      described_class.call('test')
    end

    it 'delegates to #call with no args' do
      expect_any_instance_of(described_class).to receive(:call).with(no_args)

      described_class.call('test')
    end

    it "returns result of #call" do
      allow_any_instance_of(described_class)
        .to receive(:call).and_return('test')

      expect(described_class.call).to eq 'test'
    end
  end

  describe '#call' do
    subject { described_class.new(*args) }

    it 'returns self' do
      expect(subject.call).to eq subject
    end

    it 'calls Open3.popen with #args as arguments' do
      expect(Open3).to receive(:popen3).with(*args)

      subject.call
    end

    context 'when called' do
      let(:success_result) { "success 1\nsuccess 2" }
      let(:error_result) { "error 1\nerror 2" }
      let(:exit_status) { double(value: 'test') }

      before :each do
        success_io = build_mock_io(success_result)
        error_io = build_mock_io(error_result)

        allow(Open3).to receive(:popen3)
          .and_yield(nil, success_io, error_io, exit_status)

        subject.call
      end

      it 'sets #exit_status' do
        expect(subject.exit_status).to eq exit_status.value
      end

      it 'sets #success_result' do
        expect(subject.success_result).to eq success_result
      end

      it 'sets #error_result' do
        expect(subject.error_result).to eq error_result
      end

      def build_mock_io(*lines)
        io = StringIO.new
        lines.flatten.each { |line| io.puts(line) }
        io.tap(&:rewind)
      end
    end
  end

  describe '#called?' do
    context 'when #exit_status is nil' do
      before :each do
        allow(subject).to receive(:exit_status).and_return('something')
      end

      it 'returns true' do
        expect(subject.called?).to be true
      end
    end

    context 'when #exit_status is not nil' do
      before :each do
        allow(subject).to receive(:exit_status).and_return(nil)
      end

      it 'returns false' do
        expect(subject.called?).to be false
      end
    end
  end

  describe '#success?' do
    context 'when #called? is true' do
      before :each do
        allow(subject).to receive(:called?).and_return(true)
      end

      context 'when exited successfully' do
        before :each do
          allow(subject).to receive(:exit_status) do
            double(success?: true)
          end
        end

        it 'returns true' do
          expect(subject.success?).to be true
        end
      end

      context 'when not exited successfully' do
        before :each do
          allow(subject).to receive(:exit_status) do
            double(success?: false)
          end
        end

        it 'returns false' do
          expect(subject.success?).to be false
        end
      end
    end

    context 'when #called? is false' do
      before :each do
        allow(subject).to receive(:called?).and_return(false)
      end

      it 'raises' do
        expect { subject.success? }.to raise_error('Command not invoked')
      end
    end
  end

  describe '#error?' do
    it 'calls #success?' do
      expect(subject).to receive(:success?)

      subject.error?
    end

    context 'when #success? is true' do
      before :each do
        allow(subject).to receive(:success?).and_return(true)
      end

      it 'returns false' do
        expect(subject.error?).to be false
      end
    end

    context 'when #success? is false' do
      before :each do
        allow(subject).to receive(:success?).and_return(false)
      end

      it 'returns true' do
        expect(subject.error?).to be true
      end
    end
  end

  describe '#result' do
    before :each do
      allow(subject).to receive(:success_result).and_return('success')
      allow(subject).to receive(:error_result).and_return('error')
    end

    context 'when #success? is true' do
      before :each do
        allow(subject).to receive(:success?).and_return(true)
      end

      it 'returns #success_result' do
        expect(subject.result).to eq subject.success_result
      end
    end

    context 'when #success? is false' do
      before :each do
        allow(subject).to receive(:success?).and_return(false)
      end

      it 'returns #error_result' do
        expect(subject.result).to eq subject.error_result
      end
    end
  end
end
