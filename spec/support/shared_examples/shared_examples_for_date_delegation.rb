# frozen_string_literal: true

shared_examples 'date delegation' do
  describe '#date' do
    it 'returns a Date' do
      expect(subject.date).to be_a Date
    end
  end

  describe '#year' do
    it 'matches the year from #date' do
      expect(subject.year).to eq subject.date.year
    end
  end

  describe '#month' do
    it 'matches the month from #date' do
      expect(subject.month).to eq subject.date.month
    end
  end

  describe '#day' do
    it 'matches the day from #date' do
      expect(subject.day).to eq subject.date.day
    end
  end
end
