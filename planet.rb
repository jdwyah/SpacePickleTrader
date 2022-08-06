class Planet
  attr_reader :name, :market, :destinations
  attr_accessor :description

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

  def print_welcome
    puts "Welcome to #{@name}"
    puts @description unless @description.nil?
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

PLANETS[:mars].add_demand(:mangos, 90, 20)
PLANETS[:mars].add_demand(:peanut_butter, 100, 20)
PLANETS[:mars].add_demand(:puirple_cow_ice_cream, 400, 20)
PLANETS[:mars].add_demand(:star_juice, 800, 20)
PLANETS[:mars].description = "Mars is a a dusty red place. Still, you have to check out the Marsket. Get it!? Mars-ket. Hah!"

PLANETS[:venus].add_supply(:cheese, 100, 20)
PLANETS[:venus].add_supply(:peanut_butter, 50, 20)
PLANETS[:venus].add_supply(:mangos, 50, 20)

PLANETS[:venus].add_demand(:bread, 100, 20)
PLANETS[:venus].add_demand(:coffee, 100, 20)
PLANETS[:venus].add_demand(:pasta, 100, 20)
PLANETS[:venus].description = "You've arrived at Venus, a beutiful green ball of toxic rain and extreme pressure. Bring an umbrella."


PLANETS[:saturn].add_supply(:star_juice, 100, 20)
PLANETS[:saturn].add_supply(:peanut_butter, 70, 20)
PLANETS[:saturn].add_supply(:mangos, 50, 20)
PLANETS[:saturn].add_supply(:cheese, 50, 20)

PLANETS[:saturn].add_demand(:bread, 110, 20)
PLANETS[:saturn].add_demand(:cheese, 250, 20)
PLANETS[:saturn].add_demand(:pickles, 400, 20)
PLANETS[:saturn].add_demand(:purple_cow_ice_cream, 500, 20)
PLANETS[:saturn].description = "The beautiful rings of Saturn greet you. Did you remember enough money to zoom home?"


PLANETS[:jupiter].add_supply(:purple_cow_ice_cream, 100, 20)
PLANETS[:jupiter].add_supply(:peanut_butter, 10, 20)
PLANETS[:jupiter].add_supply(:mangos, 50, 20)

PLANETS[:jupiter].add_demand(:coffee, 400, 20)
PLANETS[:jupiter].add_demand(:mangos, 100, 20)
PLANETS[:jupiter].add_demand(:pasta, 70, 20)
PLANETS[:jupiter].description = "Jupiter largest plant in the solar system. Too bad your bank account isn't this large. Yet."


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