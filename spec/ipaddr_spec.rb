TheUsual.load 'ipaddr'

RSpec.describe IPAddr do
  it 'parses full and partial addresses' do
    expect(IPAddr.new('8.8.8.8').to_s).to eq '8.8.8.8'
    expect(IPAddr.new('8.8.8.0/24').to_s).to eq '8.8.8.0'
    expect(IPAddr.new('8.8.8').to_s).to eq '8.8.8.0'
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
    end
  end
end
