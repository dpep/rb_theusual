TheUsual.load 'hash'

RSpec.describe Hash do
  let(:data) { { c: 2, b: 3, a: 1 } }

  describe '.map' do
    it 'maps keys to block results' do
      expect(Hash.map(data.keys) { |x| data[x] }).to eq data
      expect(Hash.map([]) { nil }).to eq({})
      expect(Hash.map([1, 2, 3]) { nil }).to eq(1 => nil, 2 => nil, 3 => nil)
      expect(Hash.map([1]) { [2, 3] }).to eq(1 => [2, 3])
    end

    it 'composes with compact' do
      expect(Hash.map([1, 2, 3]) { |x| true if x > 2 }.compact).to eq(3 => true)
    end
  end

  describe '.hmap' do
    it 'builds a hash from [key, value] pairs' do
      expect(Hash.hmap([1]) { [2, 3] }).to eq(2 => 3)
      expect(Hash.hmap(data) { |k, v| [k, v] }).to eq data
      expect(Hash.hmap(data.keys) { |x| [x, data[x]] }).to eq data
      expect(Hash.hmap([1, 2, 3]) { |x| [nil, x] }).to eq(nil => 3)
    end

    it 'skips nil results' do
      expect(Hash.hmap([]) { nil }).to eq({})
      expect(Hash.hmap([1, 2, 3]) { nil }).to eq({})
    end
  end

  describe '#update' do
    let(:data) { { a: 1, b: 2, c: 3 } }

    it 'merges one or more hashes into a copy' do
      expect(data.update({ d: 4 })).to eq(a: 1, b: 2, c: 3, d: 4)
      expect(data.update({ d: 4, e: 5 })).to eq(a: 1, b: 2, c: 3, d: 4, e: 5)
      expect(data.update({ d: 4 }, { e: 5 })).to eq(a: 1, b: 2, c: 3, d: 4, e: 5)
      expect(data).to eq(a: 1, b: 2, c: 3)
    end

    it 'merges in place with update!' do
      expect(data.update!({ d: 4 }, { e: 5 })).to eq(a: 1, b: 2, c: 3, d: 4, e: 5)
      expect(data).to eq(a: 1, b: 2, c: 3, d: 4, e: 5)
    end
  end

  describe '#except' do
    let(:data) { { a: 1, b: 2, c: 3 } }

    it 'drops the given keys' do
      expect(data.except(:c)).to eq(a: 1, b: 2)
      expect(data.except(:b, :c)).to eq(a: 1)
    end

    it 'drops in place with except!' do
      expect(data.except!(:b, :c)).to eq(a: 1)
      expect(data).to eq(a: 1)
    end
  end

  describe '#select_keys' do
    it 'keeps the given keys' do
      expect(data.select_keys(:c, :a)).to eq(c: 2, a: 1)
      expect(data.select_keys([:c, :a])).to eq(c: 2, a: 1)
      expect(data.slice(:c, :a)).to eq(c: 2, a: 1)
    end

    it 'includes missing keys as nil' do
      expect(data.select_keys(:c, :z)).to eq(c: 2, z: nil)
    end

    it 'selects in place with select_keys!' do
      expect(data.select_keys!(:c, :a)).to eq(c: 2, a: 1)
      expect(data).to eq(c: 2, a: 1)
    end
  end

  describe '#compact' do
    let(:data) { { a: nil, b: 'b', c: false, d: '', e: 0 } }

    it 'removes nil and false' do
      expect(data.compact).to eq(b: 'b', d: '', e: 0)
    end

    it 'removes blanks with :blanks' do
      expect(data.compact(:blanks)).to eq(b: 'b', e: 0)
    end

    it 'removes zeros and blanks with :falsy' do
      expect(data.compact(:falsy)).to eq(b: 'b')
    end

    it 'compacts in place with compact!' do
      expect(data.compact!(:falsy)).to eq(b: 'b')
      expect(data).to eq(b: 'b')
    end
  end

  describe '#hmap' do
    it 'maps [key, value] pairs' do
      expect(data.hmap { |k, v| [k, v * 2] }).to eq(c: 4, b: 6, a: 2)
      expect(data.hmap { |k, v| [(k.to_s * 2).to_sym, v * 2] }).to eq(cc: 4, bb: 6, aa: 2)
      expect({}.hmap { |k, v| [k, v * 2] }).to eq({})
    end

    it 'skips nil results' do
      expect({ a: 1 }.hmap { nil }).to eq({})
    end

    it 'maps in place with hmap!' do
      expect(data.hmap! { |k, v| [k, v * 2] }).to eq(c: 4, b: 6, a: 2)
      expect(data).to eq(c: 4, b: 6, a: 2)
    end
  end

  describe '#kmap' do
    let(:data) { { 'a' => 1, 'b' => 2, 'c' => 3 } }

    it 'maps keys and keeps values' do
      expect(data.kmap(&:to_s)).to eq data
      expect(data.kmap { |k| k * 2 }).to eq('aa' => 1, 'bb' => 2, 'cc' => 3)
      expect(data.kmap { |k, v| k * 2 }).to eq('aa' => 1, 'bb' => 2, 'cc' => 3)
    end

    it 'maps in place with kmap!' do
      expect(data.kmap! { |k, v| k * 2 }).to eq('aa' => 1, 'bb' => 2, 'cc' => 3)
      expect(data).to eq('aa' => 1, 'bb' => 2, 'cc' => 3)
    end
  end

  describe '#vmap' do
    let(:data) { { a: 1, b: 2, c: 3 } }

    it 'maps values and keeps keys' do
      expect(data.vmap(&:to_f)).to eq(a: 1.0, b: 2.0, c: 3.0)
      expect(data.vmap { |v| v * 2 }).to eq(a: 2, b: 4, c: 6)
      expect(data.vmap { |k, v| v * 2 }).to eq(a: 2, b: 4, c: 6)
      expect(data.vmap { |k, v| k }).to eq(a: :a, b: :b, c: :c)
    end

    it 'maps in place with vmap!' do
      expect(data.vmap! { |v| v * 2 }).to eq(a: 2, b: 4, c: 6)
      expect(data).to eq(a: 2, b: 4, c: 6)
    end
  end

  describe 'default values' do
    let(:data) { Hash.new(123) }

    it 'survives kmap, vmap, and hmap' do
      expect(data.kmap { nil }[:abc]).to eq 123
      expect(data.vmap { nil }[:abc]).to eq 123
      expect(data.hmap { nil }[:abc]).to eq 123
    end
  end

  describe '#ksort' do
    let(:data) { { cx: 2, by: 3, az: 1 } }

    it 'sorts by key' do
      expect(data.ksort.to_a).to eq [[:az, 1], [:by, 3], [:cx, 2]]
      expect(data.ksort { |k| k.to_s.reverse }.to_a).to eq [[:cx, 2], [:by, 3], [:az, 1]]
    end

    it 'sorts in place with ksort!' do
      expect(data.ksort!.to_a).to eq [[:az, 1], [:by, 3], [:cx, 2]]
      expect(data.to_a).to eq [[:az, 1], [:by, 3], [:cx, 2]]
    end
  end

  describe '#vsort' do
    it 'sorts by value' do
      expect(data.vsort.to_a).to eq [[:a, 1], [:c, 2], [:b, 3]]
      expect(data.vsort { |v| -v }.to_a).to eq [[:b, 3], [:c, 2], [:a, 1]]
    end

    it 'sorts in place with vsort!' do
      expect(data.vsort!.to_a).to eq [[:a, 1], [:c, 2], [:b, 3]]
      expect(data.to_a).to eq [[:a, 1], [:c, 2], [:b, 3]]
    end
  end

  describe '#-' do
    it 'removes keys present in the other hash' do
      expect({ a: 1, b: 2, c: 3 } - {}).to eq(a: 1, b: 2, c: 3)
      expect({ a: 1, b: 2, c: 3 } - { b: 1 }).to eq(a: 1, c: 3)
    end
  end

  describe '#symbolize_keys' do
    it 'symbolizes top-level keys' do
      expect({ 'a' => 1, 'b' => 2, 'c' => 3 }.symbolize_keys).to eq(a: 1, b: 2, c: 3)
      expect({ 'a' => 1, 'c' => { 'd' => 3 } }.symbolize_keys).to eq(a: 1, c: { 'd' => 3 })
    end

    it 'symbolizes nested keys when deep' do
      expect({ 'c' => { 'z' => 3 }, 'd' => ['x'] }.symbolize_keys(true)).to eq(c: { z: 3 }, d: ['x'])
      expect({ 'a' => { 'b' => { 'c' => 1 } } }.symbolize_keys(true)).to eq(a: { b: { c: 1 } })
    end

    it 'leaves the receiver alone' do
      h = { 'a' => 1 }
      h.symbolize_keys

      expect(h).to eq('a' => 1)
    end

    it 'symbolizes in place with symbolize_keys!' do
      h = { 'a' => 1, 'b' => 2 }
      h.symbolize_keys!

      expect(h).to eq(a: 1, b: 2)
    end
  end
end
