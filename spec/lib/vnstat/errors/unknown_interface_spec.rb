describe Vnstat::UnknownInterface do
  it 'inherits from Vnstat::Error' do
    expect(described_class).to be < Vnstat::Error
  end
end
