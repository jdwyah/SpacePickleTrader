class Planet
  attr_reader :name, :market, :destinations

  def initialize(name:, destinations:)
    @name = name
    @market = {supply: {}, demand: {}}
    @destinations = destinations
  end

  def add_supply(item, price, quantity)
    @market[:supply][item] = PlanetItems.new(item: item,
                                       price: price,
                                       quantity: quantity)
  end
  def add_demand(item, price, quantity)
    @market[:demand][item] = PlanetItems.new(item: item,
                                       price: price,
                                       quantity: quantity)
  end
end


PLANETS = {
  mars: Planet.new(name: 'Mars', destinations: [:venus]),
  venus: Planet.new(name: 'Venus', destinations: [:mars, :saturn]),
  saturn: Planet.new(name: 'Saturn', destinations: [:venus, :jupiter]),
  jupiter: Planet.new(name: 'Jupiter', destinations: [:saturn]),
}

PLANETS[:mars].add_supply(:pickle, 100, 20)
PLANETS[:mars].add_supply(:coffee, 50, 20)
PLANETS[:mars].add_supply(:bread, 50, 20)

PLANETS[:mars].add_demand(:peanut_butter, 100, 20)
PLANETS[:mars].add_demand(:purple_cow_ice_cream, 100, 20)
PLANETS[:mars].add_demand(:star_juice, 100, 20)


PLANETS[:venus].add_supply(:cheese, 100, 20)
PLANETS[:venus].add_supply(:peanut_butter, 50, 20)
PLANETS[:venus].add_supply(:mangos, 50, 20)

PLANETS[:venus].add_demand(:bread, 100, 20)
PLANETS[:venus].add_demand(:coffee, 100, 20)
PLANETS[:venus].add_demand(:pasta, 100, 20)

#                    market: {
#                      supply: {
#                        pickles: PlanetItems.new(item: :pickes,
#                                        price: 100,
#                                        quantity: 20),
#                       coffee: PlanetItems.new(item: :coffee,
#                                        price: 50,
#                                        quantity: 20),
#   bread: PlanetItems.new(item: :bread,
#                                        price: 50,
#                                        quantity: 20),
# },
                                    
#                      demand: {
#                       peanut_butter: PlanetItems.new(item: :peanut_butter,
#                                        price: 80,
#                                        quantity: 20),
#                        purple_cow_ice_cream: PlanetItems.new(item: :purple_cow_ice_cream,
#                                        price: 100,
#                                        quantity: 20),
# star_juice: PlanetItems.new(item: :star_juice,
#                                        price: 100,
#                                        quantity: 20),
# }
#                    })
# }