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

def display_hand_dealer(hand, reveal = false)
  first_card = hand[0]
  if !reveal
    puts "Dealer has: #{first_card.flatten.join(' ')} and one hidden card."
  else
    puts "Dealer has: #{hand.flatten.join(' ')}"
  end
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

def display_game(player, dealer, reveal = false)
  system 'clear'
  puts '* * * * * * * * * * * * * *'
  puts '*                         *'
  puts '*        MIKE\'S 21        *'
  puts '*                         *'
  puts '* * * * * * * * * * * * * *'
  puts '                    '
  display_hand_dealer(dealer, reveal)
  display_hand_player(player)
  puts ''
end

def display_exit
  puts ' '
  puts '- - - - - - - - - -'
  puts "Thanks for playing!"
  puts '- - - - - - - - - -'
end

def player_turn(player, dealer, deck)
  loop do
    display_game(player, dealer)
    answer = ''

    loop do
      print "(h)it or (s)tay on #{calculate_hand_value(player)}? => "
      answer = gets.chomp.downcase
      break if answer == 'h' || answer == 's'
      puts "Try again. Not a valid choice."
    end

    if answer == 'h'
      player = get_new_card(player, deck)
    end
    break if answer == 's' || busted?(player)
  end
end

def dealer_turn(player, dealer, deck)
  loop do
    hand_value = calculate_hand_value(dealer)
    break if hand_value >= 17 || busted?(dealer)

    dealer = get_new_card(dealer, deck)
    display_game(player, dealer, true)
  end
end

# game loop
loop do
  game_deck = initialize_deck
  player_hand = initialize_hand(game_deck)
  dealer_hand = initialize_hand(game_deck)
  
  player_turn(player_hand, dealer_hand, game_deck)
  display_game(player_hand, dealer_hand)

  if !busted?(player_hand)
    dealer_turn(player_hand, dealer_hand, game_deck)
  end

  display_game(player_hand, dealer_hand, true)
  display_winner(player_hand, dealer_hand)
  print "Press [ENTER] to continue"
  gets

  print "Play again? (y) or (n) => "
  again = gets.chomp.downcase
  break unless again == 'y'
end

display_exit
