TheUsual.load 'time'

RSpec.describe Time do
  describe '#to_ms' do
    it 'round-trips through Time.at_ms' do
      ts = Time.now.utc

      expect(ts.to_ms).to be_an Integer
      # to_ms truncates
      expect(ts - Time.at_ms(ts.to_ms)).to be <= 0.001
    end
  end

  describe '#humanize' do
    def ago(seconds) = Time.new - seconds

    it 'describes the distance to now' do
      expect(Time.new.humanize).to eq 'just now'
      expect(ago(50).humanize).to eq 'less than a minute'
      expect(ago(60).humanize).to eq 'a minute'
      expect(ago(60 * 60).humanize).to eq 'an hour'
      expect(ago(60 * 60 + 5).humanize).to eq 'an hour'
      expect(ago(60 * 61).humanize).to eq 'about an hour'
      expect(ago(60 * 60 * 24).humanize).to eq 'a day'
    end

    it 'resolves seconds when asked' do
      expect(ago(1).humanize(nil, seconds: true)).to eq 'a second'
    end
  end
end
