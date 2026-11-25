TheUsual.load :enumerable

RSpec.describe Enumerable do
  describe '#duplicates?' do
    it 'is false without repeats' do
      expect([].duplicates?).to be false
      expect([1].duplicates?).to be false
      expect([1, 2].duplicates?).to be false
      expect(['a', 'A'].duplicates?).to be false
    end

    it 'is true with repeats' do
      expect([1, 2, 1].duplicates?).to be true
      expect([{ a: 1 }, { a: 1 }].duplicates?).to be true
    end

    it 'compares block results' do
      expect([1, 2, 3].duplicates? { |v| v % 3 }).to be false
      expect(['a', 'A'].duplicates?(&:downcase)).to be true
    end

    it 'stops at the first repeat' do
      seen = []
      [1, 1, 2].duplicates? { |v| seen << v; v }

      expect(seen).to eq [1, 1]
    end

    it 'works on any Enumerable' do
      expect((1..3).duplicates?).to be false
      expect({ a: 1, b: 1 }.duplicates? { |_k, v| v }).to be true
    end
  end
end
