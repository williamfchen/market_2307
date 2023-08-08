class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map { |vendor| vendor.name }
  end

  def vendors_that_sell(item)
    @vendors.find_all { |vendor| vendor.inventory.include?(item) }
  end

  def sorted_item_list
    item_objects = @vendors.flat_map { |vendor| vendor.inventory.keys }.uniq
    sorted_items = item_objects.sort_by { |item| item.name }
    sorted_items.map { |item| item.name }
  end

  def total_inventory
    inventory = Hash.new { |h, k| h[k] = { quantity: 0, vendors: [] } }
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        inventory[item][:quantity] += quantity
        inventory[item][:vendors] += vendors_that_sell(item) unless inventory[item][:vendors].include?(vendor)
      end
    end
    inventory
  end

  def overstocked_items
    overstocked_items = total_inventory.select do |item, data|
      data[:quantity] > 50 && data[:vendors].count > 1
    end
    overstocked_items.keys
  end
end
