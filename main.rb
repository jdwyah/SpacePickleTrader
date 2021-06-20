require './planet.rb'

@planets = {
  mars: Planet.new(name: 'Mars',
                   market: {
                     pickles: 100,
                     coffee: 50
                   }),

  cow_land: Planet.new(name: 'Cow Land',
                       market: {
                         pickles: 100,
                         milk: 50,
                         chocolate_milk: 100
                       }),

  planet_3: Planet.new(name: 'Planet 3',
                       market: {
                         pickles: 100,
                         milk: 50,
                         chocolate_milk: 100
                       })
}

@money = 1000
@running = true
@current_planet = :mars
@inventory = {}

def print_market
  current_planet_obj.market.each do |thing, price|
    puts "#{thing} #{price}"
  end
end

def print_inventory
  @inventory.each do |thing, quantity|
    puts "#{quantity} #{thing}s"
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

end
def current_planet_obj
  @planets[@current_planet]
end

def buy_something
  puts 'The market has:'
  print_market
  puts 'What would you like to buy?'
  what = gets.chomp.to_sym
  if current_planet_obj.market.keys.include? what
    puts "How many #{what} would you like to buy?"
    take = gets.chomp.to_i
    cost = take * current_planet_obj.market[what]
    puts "you are buying #{take} #{what} for #{cost}"
    @inventory[what] ||= 0
    @inventory[what] += take
    @money -= cost
  else
    puts "We don't have any '#{what}'"
  end
end

def zoom_zoom
  destinations = @planets
  puts 'You can fly to:'
  destinations.each do |key, dest|
    puts dest.name
  end
  puts "Where to? [#{destinations.keys.map(&:to_s).flatten}]"
  dest = gets.chomp
  puts "You flew to #{dest} for $500"
  @money -= 500
  @current_planet = dest.to_sym
end

def main
  puts 'Welcome to SpacePickleTrader'
  puts 'What is your name?'

  @name = gets.chomp

  puts "Hello #{@name}"

  @wrong_attempts = 0
  while @running
    puts 'What would you like to do? [status,buy,zoom, exit]'
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
    else
      @wrong_attempts +=1
    end

    if @wrong_attempts == 2
      puts "Uhh are you ok?"
    end

    if @wrong_attempts == 5
      puts "Uh... I think I should call someone."
    end

    if @wrong_attempts == 10
      puts "You are coocoo for pickle flavored cocoa puffs. Space ship crashed on planet pickle flavored cocoa puffs."
      @running = false
    end

  end
end

main
