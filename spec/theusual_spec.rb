RSpec.describe TheUsual do
  describe '.load' do
    it 'returns the modules it loaded' do
      expect(TheUsual.load(:nil, 'string')).to eq ['nil', 'string']
    end

    it 'loads every available module with :all' do
      expect(TheUsual.load(:all)).to include('array', 'hash', 'time')
    end

    it 'skips modules whose library is missing with :all' do
      expect(TheUsual.load(:all)).not_to include('mongoid')
    end

    it 'raises for a missing library' do
      expect { TheUsual.load(:mongoid) }.to raise_error(ArgumentError, /gem install mongoid/)
    end

    it 'raises for an unknown module' do
      expect { TheUsual.load(:nope) }.to raise_error(ArgumentError)
    end

    it 'raises without arguments' do
      expect { TheUsual.load }.to raise_error(ArgumentError)
    end
  end
end
