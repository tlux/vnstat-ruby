describe Vnstat::Configuration do
  describe '#reset' do
    before :each do
      subject.executable_path = '/test/path/vnstat'
    end

    it 'returns self' do
      expect(subject.reset).to be subject
    end

    it 'sets #executable_path to nil' do
      expect { subject.reset }
        .to change { subject.instance_variable_get(:@executable_path) }
        .from('/test/path/vnstat').to(nil)
    end
  end

  describe '#executable_path' do
    context 'when configured' do
      before :each do
        subject.executable_path = '/test/path/vnstat'
      end

      it 'returns configured path' do
        expect(subject.executable_path).to eq '/test/path/vnstat'
      end
    end

    context 'when not configured' do
      it 'calls Utils.system_call to invoke `which vnstat`' do
        expect(Vnstat::Utils).to receive(:system_call)
          .with('which', 'vnstat')
          .and_return('/test/other_path/vnstat')

        subject.executable_path
      end

      context 'with path detected by `which vnstat`' do
        before :each do
          allow(Vnstat::Utils).to receive(:system_call)
            .with('which', 'vnstat')
            .and_return('/test/other_path/vnstat')
        end

        it 'returns detected path' do
          expect(subject.executable_path).to eq '/test/other_path/vnstat'
        end
      end

      context 'with path not detectable by `which vnstat`' do
        before :each do
          allow(Vnstat::Utils).to receive(:system_call)
            .with('which', 'vnstat').and_yield
        end

        it 'raises Vnstat::ExecutableNotFound' do
          expect { subject.executable_path }
            .to raise_error(Vnstat::ExecutableNotFound,
                            'Unable to locate vnstat executable')
        end
      end
    end
  end

  describe '#executable_path=' do
    it 'sets instance variable @executable_path' do
      expect { subject.executable_path = '/test/path/vnstat' }
        .to change { subject.instance_variable_get(:@executable_path) }
        .from(nil).to('/test/path/vnstat')
    end
  end
end
