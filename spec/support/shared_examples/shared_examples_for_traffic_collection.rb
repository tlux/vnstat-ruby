# frozen_string_literal: true

shared_examples 'traffic collection' do
  it 'includes Enumerable' do
    expect(described_class).to include Enumerable
  end

  describe '#each' do
    context 'when block given' do
      it 'returns an Array' do
        expect(subject.each {}).to be_an Array
      end
    end

    context 'when no block given' do
      it 'returns an Enumerator' do
        expect(subject.each).to be_an Enumerator
      end
    end
  end
end
