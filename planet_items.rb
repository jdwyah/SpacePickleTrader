class PlanetItems
  attr_reader :item, :price, :quantity

  def initialize(item:, price:, quantity:)
    @item = item
    @price = price
    @quantity = quantity
  end

end
