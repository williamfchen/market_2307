require './lib/item'
require './lib/vendor'

RSpec.describe Vendor do
  let(:item1) { Item.new ({name: 'Peach', price: "$0.75"}) }
  let(:item2) { Item.new({name: 'Tomato', price: '$0.50'}) }
  let(:vendor) { Vendor.new("Rocky Mountain Fresh") }

  describe '#initializes' do
    it 'exists' do
      expect(vendor).to be_a Vendor
    end

    it 'has readable attributes' do
      expect(vendor.name).to eq "Rocky Mountain Fresh"
      expect(vendor.inventory).to eq({})
    end
  end

  describe '#check_stock' do
    it 'checks the quantity of an item in the inventory' do
      expect(vendor.check_stock(item1)).to eq 0
      vendor.stock(item1, 30)
      expect(vendor.inventory).to match({
        item1 => 30,
      })
      expect(vendor.check_stock(item1)).to eq 30
      vendor.stock(item1, 25)
      expect(vendor.inventory).to match({
        item1 => 55,
      })
      expect(vendor.check_stock(item1)).to eq 55
      vendor.stock(item2, 12)
      expect(vendor.inventory).to match({
        item1 => 55,
        item2 => 12
      })
    end
  end

  describe '#potential_revenue' do
    it 'calculates potential revnue of all items * quantity' do
      expect(vendor.check_stock(item1)).to eq 0
      vendor.stock(item1, 35)
      vendor.stock(item2, 7)
      expect(vendor.potential_revenue).to eq 29.75
    end
  end
end