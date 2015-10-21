describe Vnstat do
  describe '#config' do
    subject { described_class.config }

    it { is_expected.to be_a Vnstat::Configuration }

    it 'is only instantiated once' do
      expect(subject).to be described_class.config
    end
  end

  describe '#configure' do

    pending
  end
end
