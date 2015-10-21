describe Vnstat::Utils do
  describe '.system_readlines' do
    it 'calls IO.popen with args as first arg'

    context 'when exit code is 0' do
      it 'returns all lines from stdout'
    end

    context 'when exit code is not 0' do
      it 'returns nil'
    end
  end
end
