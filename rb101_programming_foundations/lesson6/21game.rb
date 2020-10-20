require 'pry'

def initialize_deck
  suits = %w(♥ ♦ ♣ ♠)
  cards = %w(2 3 4 5 6 7 8 9 10 J Q K A)
  deck = suits.product(cards)
end

def initialize_hand(deck)
  selected = []
  selected << deck.sample << deck.sample
  selected.each { |crd| deck.delete(crd) } 
  selected
end

def display_hand_dealer(hand)
  first_card = hand[0]
  puts "Dealer has: #{first_card.flatten.join(' ')} and one hidden card."
end

def display_hand_dealer_reveal(hand)
  puts "Dealer has: #{hand.flatten.join(' ')}"
end

def display_hand_player(hand)
  puts "You have: #{hand.flatten.join(' ')}"
end

def get_new_card(hand, deck)
  hand << deck.sample
  hand.each { |card| deck.delete(card)}
  hand
end

def calculate_hand_value(hand)
  card_values = hand.map { |card| card[1]}

  sum = 0
  card_values.each do |value|
    if value == "A"
      sum += 11
    elsif ["Q", "K", "J"].include?(value)
      sum += 10
    else sum += value.to_i
    end
  end

  card_values.select { |value| value == 'A' }.count.times do
    sum -= 10 if sum > 21
  end

  sum
end

def busted?(hand)
  score = calculate_hand_value(hand)
  return true if score > 21
  false
end

#game loop
game_deck = initialize_deck
player_hand = initialize_hand(game_deck)
dealer_hand = initialize_hand(game_deck)

loop do
  system 'clear'
  display_hand_dealer(dealer_hand)
  display_hand_player(player_hand)
  puts "(h)it or (s)tay?"
  answer = gets.chomp.downcase
  if answer == 'h'
    player_hand = get_new_card(player_hand, game_deck)
  end
  break if answer == 's' || busted?(player_hand)
end

system 'clear'
display_hand_dealer(dealer_hand)
display_hand_player(player_hand)

if busted?(player_hand)
  puts "You busted."
else
  puts "You stayed."
end

#dealer turn
loop do
  value = calculate_hand_value(dealer_hand)
  break if value >= 17 || busted?(dealer_hand)
  
  dealer_hand = get_new_card(dealer_hand, game_deck)
  sleep(1)
  system "clear"
  display_hand_dealer_reveal(dealer_hand)
  display_hand_player(player_hand)
end

system "clear"
display_hand_dealer_reveal(dealer_hand)
display_hand_player(player_hand)

if busted?(dealer_hand)
  puts "dealer busts"
else
  puts 'dealer stays'
end
#compare scores
