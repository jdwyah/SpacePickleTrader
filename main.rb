require './planet.rb'

mars = Planet.new(name: "Mars", 
market: {
  pickles: 100,
  coffee: 50
}
)

@money = 1000
@running = true
@current_planet = mars
@inventory = {}

def print_market
  @current_planet.market.each do |thing, price|
    puts "#{thing} #{price}"
  end
end

def print_inventory
  @inventory.each do |thing, quantity|
    puts "#{quantity} #{thing}s"
  end
end

def status
  puts "You are on planet #{@current_planet.name}"
  puts "You have #{@money} money"
  puts "====Inventory===="
  print_inventory
  puts "====Market===="
  print_market
end

def buy_something
  puts "The market has:"
  print_market
  puts "What would you like to buy?"
  what = gets.chomp.to_sym
  if @current_planet.market.keys.include? what
    puts "How many #{what} would you like to buy?"
    take = gets.chomp.to_i
    cost = take * @current_planet.market[what]
    puts "you are buying #{take} #{what} for #{cost}"
    @inventory[what] ||=0
    @inventory[what] += take
    @money -= cost
  else
    puts "We don't have any '#{what}'"
  end

end

def main

  puts "Welcome to SpacePickleTrader"
  puts "What is your name?"
  
  @name = gets.chomp

  puts "Hello #{@name}"
  while @running 
    puts "What would you like to do? [status,buy, exit]"
    input = gets.chomp

    case input
    when 'status'
      status
    when 'exit'
      @running = false  
    when "buy"
      buy_something
    end

  end

end

main
