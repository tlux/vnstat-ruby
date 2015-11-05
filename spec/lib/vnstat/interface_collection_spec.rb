describe Vnstat::InterfaceCollection do
  let :data do
    <<-XML
      <vnstat version="0.00" xmlversion="1">
        <interface id="eth0"></interface>
        <interface id="wlan0"></interface>
      </vnstat>
    XML
  end

  subject { described_class.new(data) }

  it { is_expected.to be_a Vnstat::Document }

  describe '.open' do
    pending
  end

  describe '#[]' do
    context 'when existing interface given' do
      context 'with String argument' do
        it 'returns Vnstat::Interface' do
          expect(subject['eth0']).to be_a Vnstat::Interface
        end

        it 'returns object with id matching the given argument' do
          expect(subject['eth0'].id).to eq 'eth0'
        end
      end

      context 'with symbolic argument' do
        it 'returns Vnstat::Interface' do
          expect(subject[:eth0]).to be_a Vnstat::Interface
        end

        it 'returns object with id matching the given argument' do
          expect(subject[:eth0].id).to eq 'eth0'
        end
      end
    end

    context 'when non-existing interface given' do
      it 'raises Vnstat::UnknownInterface' do
        expect { subject['eth1'] }.to raise_error(Vnstat::UnknownInterface)
      end
    end
  end
end
