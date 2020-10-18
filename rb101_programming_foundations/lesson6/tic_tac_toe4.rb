FIRST = 'choose'
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]

def prompt(str)
  puts "=> #{str}"
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts "*** TIC TAC TOE v1.2 ***"
  puts "You are an #{PLAYER_MARKER}, computer is #{COMPUTER_MARKER}"
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def joinor(num_array, sep = ', ', word = 'or')
  output = ''
  case num_array.size
  when 0 then return ''
  when 1 then return num_array.last.to_s
  when 2 then return num_array.join(" #{word} ")
  else
    num_array.each do |num|
      break if num == num_array.last
      output << num.to_s + sep
    end
    output << "#{word} #{num_array.last}"
  end
  output
end

def place_piece!(brd, player)
  if player == 'human'
    player_places_piece(brd)
  elsif player == 'computer'
    computer_places_piece(brd)
  end
end

def player_places_piece(brd)
  square = ''
  loop do
    prompt "Choose a square: (#{joinor(empty_squares(brd))})"
    square = gets.chomp.to_i
    if empty_squares(brd).include?(square)
      break
    else
      prompt "Sorry, invalid choice."
    end
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece(brd)
  square = line_check(brd, COMPUTER_MARKER)
  square = line_check(brd, PLAYER_MARKER) if !square
  if !square
    square = 5 if brd[5] == INITIAL_MARKER
  end
  square = empty_squares(brd).sample if !square
  brd[square] = COMPUTER_MARKER
end

def line_check(brd, marker)
  square = nil
  WINNING_LINES.each do |line|
    square = find_at_risk_square(line, brd, marker)
    break if square
  end
  square
end

def find_at_risk_square(line, brd, marker)
  if brd.values_at(*line).count(marker) == 2
    brd.select { |k, v| line.include?(k) && v == INITIAL_MARKER }.keys.first
  end
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def update_score(scores, brd)
  scores[:human] += 1 if detect_winner(brd) == 'Player'
  scores[:computer] += 1 if detect_winner(brd) == 'Computer'
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def alternate_player(player)
  if player == 'human'
    'computer'
  elsif player == 'computer'
    'human'
  end
end

def first_move
  answer = ''
  if FIRST == 'choose'
    loop do
      system 'clear'
      prompt "*** TIC TAC TOE v1.2 ***"
      prompt 'Who goes first? (h) human or (c) computer'
      answer = gets.chomp.downcase
      break if answer == 'c' || answer == 'h'
      prompt "Invalid choice try again."
    end
  elsif FIRST == 'player' then answer = 'h'
  end
  answer == 'h' ? 'human' : 'computer'
end

def display_scores(hsh)
  prompt "Player: #{hsh[:human]} | Computer: #{hsh[:computer]} "
end

def display_winner(winner)
  if winner == 'human'
    prompt "GAME OVER. You won!"
  elsif winner == 'computer'
    prompt "GAME OVER. The computer beat you."
  end
end

# main game loop
loop do
  scores = { human: 0, computer: 0 }
  first_player = first_move

  loop do
    board = initialize_board
    current_player = first_player

    loop do
      display_board(board)
      display_scores(scores)
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)

      break if board_full?(board) || someone_won?(board)
    end

    update_score(scores, board) if someone_won?(board)

    break if scores[:human] == 5 || scores[:computer] == 5
  end

  system 'clear'
  scores[:human] == 5 ? display_winner('human') : display_winner('computer')
  prompt "Play again? (y or n)"
  answer = gets.chomp

  break unless answer.downcase.start_with?('y')
end

prompt "thanks for playing tic tac toe"
