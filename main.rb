require './planet_items.rb'
require './planet.rb'

# TODO
# pirate raids while in space
# each planet buys only some things
# coffee
# milk
# chocolate_milk
# pickles


@money = 2000
@running = true
@current_planet = :mars
@inventory = {}

def print_market
  current_planet_obj.market[:supply].each do |key, item|
    puts "this planet sells #{key} #{item.price}"
  end
  current_planet_obj.market[:demand].each do |key, item|
    puts "this planet buys #{key} #{item.price}"
  end
end

def print_inventory
  @inventory.each do |thing, quantity|
    puts "#{quantity} #{thing}"
  end
end

def status
  puts "You are on planet #{current_planet_obj.name}"
  puts "You have #{@money} money"
  puts '====Inventory===='
  print_inventory
  puts '====Market===='
  print_market
end

def sell_something
  print_inventory
  puts  "What do you want to sell?"
  what = gets.chomp.to_sym
  if @inventory[what].nil? || @inventory[what] <=0
    puts "Uh.. you don't have any #{what}"
    return
  end

  if current_planet_obj.market[:demand][what].item != what
    puts "Planet #{@current_planet} doesn't buy #{what}."
    puts current_planet_obj.market[:demand][what].item
    return
  end

  puts "Ok, how many #{what} do you want to sell? You have #{@inventory[what]} #{what} and they sell for #{current_planet_obj.market[:demand][what].price} each."

  count = gets.chomp.to_i

  gain = current_planet_obj.market[:demand][what].price * count

  @inventory[what] -= count

  @money += gain

  puts "Sold #{count} #{what} for $#{gain}."
end

def current_planet_obj
  PLANETS[@current_planet]
end

def buy_something
  puts 'The market has:'
  print_market
  puts 'What would you like to buy?'
  what = gets.chomp.to_sym
  if current_planet_obj.market[:supply].keys.include? what
    puts "How many #{what} would you like to buy?"
    take = gets.chomp.to_i
    cost = take * current_planet_obj.market[:supply][what].price
    puts "you are buying #{take} #{what} for #{cost}"
    if cost > @money
      puts "wait a second, you don't have enough money, you only have $#{@money}"
      return
    end
    @inventory[what] ||= 0
    @inventory[what] += take
    @money -= cost
  else
    puts "We don't have any '#{what}'"
  end
end

def zoom_zoom
  destinations = PLANETS
  puts 'You can fly to:'
  current_planet_obj.destinations.each do |dest|
    puts dest
  end
  puts "Where to? [#{current_planet_obj.destinations.map(&:to_s).flatten.join(", ")}]"
  dest = gets.chomp

  flight_cost = 500

  if @money < flight_cost
    puts "Not enough money for the flight! Sorry, it costs #{flight_cost} and you only have #{@money}"
    return
  end
  puts "You flew to #{dest} for $#{flight_cost}"
  @money -= flight_cost
  @current_planet = dest.to_sym
end

def main
  puts 'Welcome to SpacePickleTrader'
  puts 'What is your name?'

  @name = gets.chomp

  puts "Hello #{@name}"

  @wrong_attempts = 0
  while @running
    puts 'What would you like to do? [status,buy,sell, zoom, exit]'
    input = gets.chomp

    case input
    when 'status'
      status
    when 'exit'
      @running = false
    when 'buy'
      buy_something
    when 'zoom'
      zoom_zoom
     when 'sell'
      sell_something
    else
      @wrong_attempts += 1
    end

    puts 'Uhh are you ok?' if @wrong_attempts == 2

    puts 'Uh... I think I should call someone.' if @wrong_attempts == 5

    if @wrong_attempts == 10
      puts 'You are coocoo for pickle flavored cocoa puffs. Space ship crashed on planet pickle flavored cocoa puffs.'
      @running = false
    end

  end
end

main
