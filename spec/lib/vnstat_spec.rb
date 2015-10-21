describe Vnstat do
  describe '#config' do
    subject { described_class.config }

    it { is_expected.to be_a Vnstat::Configuration }

    it 'is only instantiated once' do
      expect(subject).to be described_class.config
    end
  end

  describe '#configure' do
    context 'when no block given' do
      it 'raises' do
        expect { described_class.configure }
          .to raise_error(LocalJumpError, 'no block given (yield)')
      end
    end

    context 'when block given' do
      pending
    end
  end

  describe '#document' do
    it 'is a Vnstat::Document' do
      expect(subject.document).to be_a Vnstat::Document
    end

    it 'calls Vnstat::Document.open' do
      expect(Vnstat::Document).to receive(:open)
        .and_return(Vnstat::Document.new(''))

      subject.document
    end
  end
end
