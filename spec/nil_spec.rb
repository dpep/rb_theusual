TheUsual.load :nil

RSpec.describe NilClass do
  it { expect(nil.empty?).to be true }
end
