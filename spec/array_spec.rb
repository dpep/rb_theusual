TheUsual.load 'array'

RSpec.describe Array do
  describe '.wrap' do
    it 'wraps non-arrays and passes arrays through' do
      expect(Array.wrap(nil)).to eq []
      expect(Array.wrap([])).to eq []
      expect(Array.wrap(1)).to eq [1]
      expect(Array.wrap([1, 2, 3])).to eq [1, 2, 3]
    end
  end

  describe '#sum' do
    it { expect([1, 2, 3].sum).to eq 6 }

    it 'adds an initial value' do
      expect([1, 2, 3].sum(10)).to eq 16
      expect([].sum(10)).to eq 10
    end

    it 'sums block results' do
      expect(['a', 'bc'].sum { |s| s.size }).to eq 3
    end
  end

  describe '#avg' do
    it 'averages the elements' do
      expect([1, 2, 3].avg).to eq 2
      expect([1, 2, 3, 4].avg).to eq 2.5
    end
  end

  describe '#grepv' do
    it 'selects elements that do not match' do
      data = ['a', 'ab', 'bab', 'bbb', 'ccc']

      expect(data.grep(/a/)).to contain_exactly('a', 'ab', 'bab')
      expect(data.grepv(/a/)).to contain_exactly('bbb', 'ccc')
    end
  end

  describe '#gsub' do
    it 'substitutes within each element' do
      expect(['aba', 'bab'].gsub(/b/, '_')).to eq ['a_a', '_a_']
      expect(['abBA'].gsub(/b/i, '_')).to eq ['a__A']
    end

    it 'substitutes in place with gsub!' do
      data = ['aba']

      expect(data.gsub!(/b/, '_')).to eq ['a_a']
      expect(data).to eq ['a_a']
    end
  end

  describe '#compact' do
    it 'removes nil and false' do
      expect([0, true, 'hi'].compact).to eq [0, true, 'hi']
      expect([nil, 0, false, ''].compact).to eq [0, '']
    end

    it 'removes blanks with :blanks' do
      expect([nil, 0, false, ''].compact(:blanks)).to eq [0]
    end

    it 'removes zeros and blanks with :falsy' do
      expect([nil, 0, false, ''].compact(:falsy)).to eq []
      expect([nil, 0, false, '', 1, 'a'].compact(:falsy)).to eq [1, 'a']
    end

    it 'compacts in place with compact!' do
      data = [nil, 0, false, '', 1, 'a']

      expect(data.compact!(:falsy)).to eq [1, 'a']
      expect(data).to eq [1, 'a']
    end
  end
end
