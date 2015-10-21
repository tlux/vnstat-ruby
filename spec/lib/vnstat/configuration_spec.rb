describe Vnstat::Configuration do
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
      it 'calls Utils.system_readlines to call `which vnstat`' do
        expect(Vnstat::Utils).to receive(:system_readlines)
          .with('which', 'vnstat')
          .and_return('/test/other_path/vnstat')

        subject.executable_path
      end

      context 'with path detected by `which vnstat`' do
        before :each do
          allow(Vnstat::Utils).to receive(:system_readlines)
            .with('which', 'vnstat')
            .and_return('/test/other_path/vnstat')
        end

        it 'returns detected path' do
          expect(subject.executable_path).to eq '/test/other_path/vnstat'
        end
      end

      context 'with path not detectable by #find_executable_path' do
        before :each do
          allow(Vnstat::Utils).to receive(:system_readlines)
            .with('which', 'vnstat').and_return(nil)
        end

        it 'raises' do
          expect { subject.executable_path }
            .to raise_error(Vnstat::Error, 'Unable to find vnstat executable')
        end
      end
    end
  end
end
