TheUsual.load :string

RSpec.describe String do
  describe '#is_i?' do
    it 'is true for integers' do
      expect('1'.is_i?).to be true
      expect('10'.is_i?).to be true
      expect('0'.is_i?).to be true
    end

    it 'is false for anything else' do
      expect('1.0'.is_i?).to be false
      expect('abc'.is_i?).to be false
      expect('123abc'.is_i?).to be false
    end
  end

  describe '#is_f?' do
    it 'is true for floats' do
      expect('1.0'.is_f?).to be true
    end

    it 'is false for anything else' do
      expect('1'.is_f?).to be false
      expect('10'.is_f?).to be false
      expect('0'.is_f?).to be false
      expect('abc'.is_f?).to be false
      expect('123.4 abc'.is_f?).to be false
    end
  end

  describe '#to_bool' do
    it 'parses booleans case-insensitively' do
      expect('true'.to_bool).to be true
      expect('True'.to_bool).to be true
      expect('false'.to_bool).to be false
    end
  end
end
