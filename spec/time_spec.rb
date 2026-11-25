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

    context 'with a fixed reference time' do
      let(:now) { Time.utc(2020, 6, 1) }

      def humanize(seconds, **opts) = (now - seconds).humanize(now, opts)

      it 'buckets seconds' do
        expect(humanize(3, seconds: true)).to eq 'less than 5 seconds'
        expect(humanize(7, seconds: true)).to eq 'less than 10 seconds'
        expect(humanize(20, seconds: true)).to eq 'less than 30 seconds'
        expect(humanize(35, seconds: true)).to eq 'half a minute'
        expect(humanize(45, seconds: true)).to eq 'less than a minute'
      end

      it 'buckets minutes and hours' do
        expect(humanize(5 * 60)).to eq '5 minutes'
        expect(humanize(50 * 60)).to eq 'about an hour'
        expect(humanize(59 * 60)).to eq 'about an hour'
        expect(humanize(5 * 3600)).to eq 'about 5 hours'
      end

      it 'buckets days and months' do
        expect(humanize(3 * 86_400)).to eq '3 days'
        expect(humanize(45 * 86_400)).to eq 'about 2 months'
        expect(humanize(120 * 86_400)).to eq '4 months'
      end

      it 'buckets years' do
        expect(humanize(770 * 86_400)).to eq 'about 2 years'
        expect(humanize(915 * 86_400)).to eq 'over 2 years'
        expect(humanize(1060 * 86_400)).to eq 'almost 3 years'
      end

      it 'uses singular units for one' do
        expect(humanize(31 * 86_400)).to eq 'about 1 month'
        expect(humanize(370 * 86_400)).to eq 'about 1 year'
        expect(humanize(550 * 86_400)).to eq 'over 1 year'
        expect(humanize(320 * 86_400)).to eq '11 months'
      end

      it 'is symmetric' do
        expect(now.humanize(now - 5 * 60)).to eq '5 minutes'
      end
    end
  end
end
