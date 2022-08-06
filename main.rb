require 'rainbow/refinement'
using Rainbow
require './planet_items.rb'
require './planet.rb'

# TODO
# pirate raids while in space
# battle chance
## basic lasers  1
## basic shields 1
## shoot lasers. compare lasers.  laser 3 vs shields 1. they take your stuff.
## celestial cow beings
## run away. send you back.
# #change flight cost to by gas minus one
# do all planets sell gas?

@money = 2000
@running = true
@current_planet = :mars
@inventory = {}

@hull_strength = 100
@shield_level = 1
@lazer_level = 0

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
  puts '====Shippie===='
  puts 'Your ship is... uh... well it can stay airborne...    mostly'
  puts "shield level: #{@shield_level} pew pew level: #{@lazer_level}"
  puts "You have #{@money} money"
  puts '====Inventory===='
  print_inventory
  puts '====Market===='
  print_market
end

def sell_something
  print_inventory
  puts 'What do you want to sell?'
  what = gets.chomp.to_sym
  if @inventory[what].nil? || @inventory[what] <= 0
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

def pew_pew_battle
  # generate bad guy

  bad_guys = [{
    hull_strength: 100,
    lasers: 3,
    shields: 3,
    name: 'Frankie',
    description: 'frankie doodle',
    battle_cries: ['Frankie doodle went to town | and blew up your space ship.'],
    retreat_cry: 'Frankie doodle ran away ay | from your viscious space ship.'
  }, {
    hull_strength: 100,
    lasers: 3,
    shields: 3,
    name: 'Bob',
    description: 'Bob the genaric guy',
    battle_cries: [''],
    retreat_cry: ''
  }, {
    hull_strength: 100,
    lasers: 6,
    shields: 1,
    name: 'Flinston',
    description: "Flinston McFlipperface: The lazer lovin' duck an ecsapee from Farmer Browns' farm who ran off to, in his words \"Make things go BOOM!!!!\"  ",
    battle_cries: ['Quack quack quack (then maniacle laughter'],
    retreat_cry: 'Quack quack (what it means: why would I understand duck? YOU go learn duck if you want to know).'
  }, {

    hull_strength: 1000,
    lasers: 0,
    shields: 18,
    name: 'Floyd',
    description: 'Floyd the verrrrrrrrrrrrrry paranoid hairdresser a.k.a. a barber gone bad',
    battle_cries: ['Snip snip snip!', ''],
    retreat_cry: 'You win this round, but your haircut is still ugly.',
    cargo: [100, :star_juice]
  }]
  bad_guy = bad_guys.sample
  # tell player the bad guys are there

  puts "🛸"  
  puts "🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀"
  puts "All yu wanted to do was zoom. YOU didn't want to b'ow things up (I hope). But the Celestial Cow Beings had other ideas."
  puts "#{@name} meet #{bad_guy[:description]}. You may now commence killing and pilaging each other."



  # ask user if they want to run or fight
  puts "Do you want to [run, fight]?"
  input = gets.chomp

  if input == 'fight'
    fight(bad_guy)
  
  elsif input == 'run'
    puts "Run away!!"
    #if r'n set dest'nation back to where they were

  else
    puts "???" 
  end
  
end

def fight(bad_guy)
  # have ba guys say something 
  puts "#{bad_guy[:name]} says #{bad_guy[:battle_cries].sample}"


    # if no cow goddesses
    
  #   bad_guy_shields = 2
  #   bad_guy_lasers = 2
  our_lasers = 1

  puts "#{@lazer_level.to_f} #{bad_guy[:shields].to_f}"
 
  we_hit = (100 * (@lazer_level.to_f / bad_guy[:shields].to_f)).to_i
  bad_guy[:hull_strength] -= we_hit

  puts "Lasers fl y!  You do #{we_hit} damage."
  
  they_hit = (100 * (bad_guy[:lasers].to_f / @shield_level.to_f)).to_i
  @hull_strength -= they_hit

  puts "Lasers fl y!  They do #{they_hit} damage."

  
    
#  we_hit_them = 100* our_lasers / bad_guy_shields # = 50 hits
  #   they_hit_us = 100 * their /our shiels = #200 hits 

  #   health_reactor_core_bar = 1000
  
#   round 1:  we hit either 50 or 0 if we miss
  #   round 1:  they hit either 200 or 0 if we miss
 # i we get to half health... they take all the cargo. 
  
  # do you want to run aw

end

def zoom_zoom
  destinations = PLANETS
  puts 'You can fly to:'
  current_planet_obj.destinations.each do |dest|
    puts dest
  end
  puts "Where to? [#{current_planet_obj.destinations.map(&:to_s).flatten.join(", ")}]"
  dest = gets.chomp
  pew_pew_battle
  
  flight_cost = 500

  if @money < flight_cost
    puts "Not enough money for the flight! Sorry, it costs #{flight_cost} and you only have #{@money}"
    return
  end
  @money -= flight_cost
@current_planet = dest.to_sym
  
  puts "🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀"
  puts "You flew to #{dest} for $#{flight_cost}"
  current_planet_obj.print_welcome
  puts "🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀'🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀"
end

def underline_first(word, count =1)
  word.slice(0,count).underline + word[count..-1]
end

def main
  puts 'Welcome to SpacePickleTrader'
  puts 'What is your name?'

  @name = gets.chomp

  puts "Hello #{@name}"

  @wrong_attempts = 0
  while @running
    puts "What would you like to do? [#{underline_first('info')},#{underline_first('buy')},#{underline_first('sell')}, #{underline_first('zoom')}, exit]"
    input = gets.chomp

    case input
    when 'info', 'i'
      status
    when 'exit'
      @running = false
    when 'buy', 'b'
      buy_something
    when 'zoom', 'z'
     zoom_zoom
     when 'sell', 's'
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
