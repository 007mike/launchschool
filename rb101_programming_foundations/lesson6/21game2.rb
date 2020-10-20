require 'pry'

def initialize_deck
  suits = %w(♥ ♦ ♣ ♠)
  cards = %w(2 3 4 5 6 7 8 9 10 J Q K A)
  suits.product(cards)
end

def initialize_hand(deck)
  selected = []
  selected << deck.sample << deck.sample
  selected.each { |card| deck.delete(card) }
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
  hand.each { |card| deck.delete(card) }
  hand
end

# rubocop:disable Metrics/AbcSize
def calculate_hand_value(hand)
  card_values = hand.map { |card| card[1] }

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
# rubocop:enable Metrics/AbcSize

def busted?(hand)
  score = calculate_hand_value(hand)
  return true if score > 21
  false
end

def display_winner(hand1, hand2)
  score1 = calculate_hand_value(hand1)
  score2 = calculate_hand_value(hand2)

  if score1 > 21
    puts "You busted. Dealer won."
  elsif score2 > 21
    puts "Dealer busted. You win."
  elsif score2 > score1
    puts "Dealer won #{score2} - #{score1}."
  elsif score1 == score2
    puts "Dealer wins a tie of #{score1}."
  elsif score1 > score2
    puts "You won #{score1} - #{score2}. "
  end
end

def display_game(player, dealer)
  system 'clear'
  puts '*******************'
  puts '*                 *'
  puts '*    MIKE\'S 21    *'
  puts '*                 *'
  puts '*******************'
  puts '                    '
  display_hand_dealer(dealer)
  display_hand_player(player)
  puts ''
end

def display_game_reveal(player, dealer)
  system 'clear'
  puts '*******************'
  puts '*                 *'
  puts '*    MIKE\'S 21    *'
  puts '*                 *'
  puts '*******************'
  puts '                    '
  display_hand_dealer_reveal(dealer)
  display_hand_player(player)
  puts ''
end

# game loop
loop do
  game_deck = initialize_deck
  player_hand = initialize_hand(game_deck)
  dealer_hand = initialize_hand(game_deck)

  # player turn
  loop do
    display_game(player_hand, dealer_hand)
    answer = ''

    loop do
      puts "(h)it or (s)tay on #{calculate_hand_value(player_hand)}?"
      answer = gets.chomp.downcase
      break if answer == 'h' || answer == 's'
      puts "Try again. Not a valid choice."
    end

    if answer == 'h'
      player_hand = get_new_card(player_hand, game_deck)
    end
    break if answer == 's' || busted?(player_hand)
  end

  display_game(player_hand, dealer_hand)

  # dealer turn
  if !busted?(player_hand)
    loop do
      value = calculate_hand_value(dealer_hand)
      break if value >= 17 || busted?(dealer_hand)

      dealer_hand = get_new_card(dealer_hand, game_deck)
      display_game_reveal(player_hand, dealer_hand)
    end
  end

  display_game_reveal(player_hand, dealer_hand)
  display_winner(player_hand, dealer_hand)

  puts "Play again? (y) or (n)"
  again = gets.chomp.downcase
  break unless again == 'y'
end
