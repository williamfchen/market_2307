require './lib/item'
require './lib/vendor'
require './lib/market'

RSpec.describe Market do
  let(:market) { Market.new("South Pearl Street Farmers Market") }
  let(:vendor1) { Vendor.new("Rocky Mountain Fresh") }
  let(:item1) { Item.new ({name: 'Peach', price: "$0.75"}) }
  let(:item2) { Item.new({name: 'Tomato', price: '$0.50'}) }
  let(:item3) { Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"}) }
  let(:item4) { Item.new({name: "Banana Nice Cream", price: "$4.25"}) }
  let(:vendor2) { Vendor.new("Ba-Nom-a-Nom") }
  let(:vendor3) { Vendor.new("Palisade Peach Shack") }
  
  describe '#initializes' do
    it 'exists' do
      expect(market).to be_a Market
    end

    it 'has readable attributes' do
      expect(market.name).to eq "South Pearl Street Farmers Market"
      expect(market.vendors).to eq([])
    end
  end

  context "iteration 2" do
    before :each do
      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3.stock(item1, 65)
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)
    end

    describe '#add_vendor' do
      it 'adds the vendor to the vendors array' do
        expect(market.vendors).to eq([vendor1, vendor2, vendor3])
      end
    end

    describe '#vendor_names' do
      it 'holds the vendors and can return and array of their names' do
        expect(market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
      end
    end

    describe '#vendors_that_sell' do
      it 'returns an array of the vendors that sell the requested item' do
        expect(market.vendors_that_sell(item1)).to eq([vendor1, vendor3])
        expect(market.vendors_that_sell(item4)).to eq([vendor2])
      end
    end

    it 'tracks potential revenue' do
      expect(vendor1.potential_revenue).to eq 29.75
      expect(vendor2.potential_revenue).to eq 345.00
      expect(vendor3.potential_revenue).to eq 48.75
    end
  end
end