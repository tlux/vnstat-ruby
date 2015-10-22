describe Vnstat do
  it 'test' do
    binding.pry
  end
  
  describe '.config' do
    subject { described_class.config }

    it { is_expected.to be_a Vnstat::Configuration }

    it 'is only instantiated once' do
      expect(subject).to be described_class.config
    end
  end

  describe '.configure' do
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

  describe '.document' do
    it 'calls Vnstat::Document.open' do
      expect(Vnstat::Document).to receive(:open)
        .and_return(Vnstat::Document.new(''))

      subject.document
    end
  end

  describe '.[]' do
    it 'is delegated to .document' do
      allow(described_class).to receive(:document) do
        { 'eth0' => 'test' }
      end

      expect(described_class['eth0']).to eq 'test'
    end
  end

  describe '.version' do
    it 'is delegated to .document' do
      document = double(version: '1.23')
      allow(described_class).to receive(:document).and_return(document)

      expect(described_class.version).to eq '1.23'
    end
  end
end
