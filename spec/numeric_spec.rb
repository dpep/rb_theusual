TheUsual.load :numeric

RSpec.describe Numeric do
  describe '#with_delimiter' do
    it 'delimits integers' do
      expect(1_000.with_delimiter).to eq '1,000'
      expect(1_000_000.with_delimiter).to eq '1,000,000'
      expect(1_000.with_delimiter('_')).to eq '1_000'
    end

    it 'delimits floats' do
      expect(1_000.0.with_delimiter).to eq '1,000.0'
      expect(1_000.123.with_delimiter).to eq '1,000.123'
    end
  end
end
