TheUsual.load 'ipaddr'

RSpec.describe IPAddr do
  it 'parses full and partial addresses' do
    expect(IPAddr.new('8.8.8.8').to_s).to eq '8.8.8.8'
    expect(IPAddr.new('8.8.8.0/24').to_s).to eq '8.8.8.0'
    expect(IPAddr.new('8.8.8').to_s).to eq '8.8.8.0'
  end

  it 'expands shortened addresses to their network' do
    expect(IPAddr.new('8.8')).to eq IPAddr.new('8.8.0.0/16')
    expect(IPAddr.new('8')).to eq IPAddr.new('8.0.0.0/8')
  end

  it 'defaults to the IPv6 unspecified address' do
    expect(IPAddr.new).to be_ipv6
    expect(IPAddr.new.to_s).to eq '::'
  end

  it 'accepts an IPAddr' do
    addr = IPAddr.new('8.8.8.8')

    expect(IPAddr.new(addr).to_s).to eq '8.8.8.8'
  end

  describe '#short' do
    it 'drops octets outside the mask' do
      expect(IPAddr.new('8.8.8.0/24').short).to eq '8.8.8'
      expect(IPAddr.new('8.8.8').short).to eq '8.8.8'
      expect(IPAddr.new('8.8.8.0').short).to eq '8.8.8.0'
      expect(IPAddr.new('8.8.8.8/16').short).to eq '8.8'
      expect(IPAddr.new('8.8.8.8/8').short).to eq '8'
    end

    it 'takes an explicit size' do
      expect(IPAddr.new('8.8.8.8').short(24)).to eq '8.8.8'
      expect(IPAddr.new('8.8.8.8').short(20)).to eq '8.8.8.8'
    end

    it 'is nil for IPv6' do
      expect(IPAddr.new('::1').short).to be_nil
    end
  end
end
