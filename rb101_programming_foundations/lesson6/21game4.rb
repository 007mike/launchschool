WIN_TOTAL = 21
DEALER_STAY = 17

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

def display_hand_dealer(hand, reveal)
  first_card = hand[0]
  if !reveal
    puts "Dealer has =>\t #{first_card.flatten.join(' ')} [ ? ]"
  else
    puts "Dealer has =>\t #{hand.flatten.join(' ')}"
  end
end

def display_hand_player(hand)
  puts "You have =>\t #{hand.flatten.join(' ')}"
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
    sum -= 10 if sum > WIN_TOTAL
  end

  sum
end
# rubocop:enable Metrics/AbcSize

def busted?(hand)
  score = calculate_hand_value(hand)
  return true if score > WIN_TOTAL
  false
end

def display_winner(player, dealer)
  p_score = calculate_hand_value(player)
  d_score = calculate_hand_value(dealer)

  if p_score > WIN_TOTAL
    puts "You busted. Dealer won."
  elsif d_score > WIN_TOTAL
    puts "Dealer busted. You win."
  elsif d_score > p_score
    puts "Dealer won #{d_score} - #{p_score}."
  elsif p_score == d_score
    puts "Dealer wins a tie of #{p_score}."
  elsif p_score > d_score
    puts "You won #{p_score} - #{d_score}. "
  end
end

def display_game(player, dealer, reveal, score)
  system 'clear'
  puts '* * * * * * * * * * * * * * * * * *'
  puts '*                                 *'
  puts "*            MIKE\'S #{WIN_TOTAL}            *"
  puts '*                                 *'
  puts '* * * * * * * * * * * * * * * * * *'
  puts ' '
  display_score(score)
  puts ' '
  display_hand_dealer(dealer, reveal)
  display_hand_player(player)

  puts ''
end

def display_exit
  puts ' '
  puts '* * * * * * * * * * * * * * * * * *'
  puts "*       Thanks for playing!       *"
  puts '* * * * * * * * * * * * * * * * * *'
end

def player_turn(player, dealer, deck, score)
  loop do
    display_game(player, dealer, false, score)
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

def dealer_turn(player, dealer, deck, score)
  loop do
    dealer_value = calculate_hand_value(dealer)
    player_value = calculate_hand_value(player)

    break if dealer_value >= DEALER_STAY || busted?(dealer)

    dealer = get_new_card(dealer, deck)
    display_game(player, dealer, true, score)
  end
end

def update_score(score, player, dealer)
  p_score = calculate_hand_value(player)
  d_score = calculate_hand_value(dealer)

  if p_score > d_score && p_score <= WIN_TOTAL || busted?(dealer)
    score[:player] += 1
  elsif d_score >= p_score && d_score <= WIN_TOTAL || busted?(player)
    score[:dealer] += 1
  end
end

def display_score(score)
  puts ">>> [ Player ] #{score[:player]} : #{score[:dealer]} [ Dealer ] <<<"
end

def display_match_winner(score)
  if score[:player] == 5
    puts "Congrats, you won the game!"
  else
    puts "The dealer won the game."
  end
end

# game loop
loop do
  scores = { player: 0, dealer: 0 }
  quit = ''

  loop do
    game_deck = initialize_deck
    player_hand = initialize_hand(game_deck)
    dealer_hand = initialize_hand(game_deck)

    player_turn(player_hand, dealer_hand, game_deck, scores)
    display_game(player_hand, dealer_hand, false, scores)

    if !busted?(player_hand)
      dealer_turn(player_hand, dealer_hand, game_deck, scores)
    end

    update_score(scores, player_hand, dealer_hand)
    display_game(player_hand, dealer_hand, true, scores)
    display_winner(player_hand, dealer_hand)

    break if scores[:player] == 5 || scores[:dealer] == 5

    print "\n[ ENTER ] to continue or\n(q) to quit current game. => "
    quit = gets.chomp

    break if quit =~ /[a-zA-Z0-9]/
  end

  display_match_winner(scores) unless quit != ''

  print "\nPlay again? (y) or (n) => "
  again = gets.chomp.downcase
  break unless again == 'y'
end

display_exit
