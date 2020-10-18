require 'pry'

FIRST = 'choose'
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]]            # diags


def prompt(str)
  puts "=> #{str}"
end

def display_board(brd)
  system 'clear'
  puts "*** TIC TAC TOE v1.2 ***"
  puts "You are an #{PLAYER_MARKER}, computer is #{COMPUTER_MARKER}"
  puts ""
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
  return '' if num_array.size == 0
  return num_array.last.to_s if num_array.size == 1
  num_array.each do |num|
    break if num == num_array.last
    output << num.to_s + sep
  end
  output << word +' '+ + num_array.last.to_s
  output
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
  square = nil
  WINNING_LINES.each do |line|
    square = find_at_risk_square(line, brd, COMPUTER_MARKER)
    break if square
  end

  if !square
    WINNING_LINES.each do |line|
      square = find_at_risk_square(line, brd, PLAYER_MARKER)
      break if square
    end
  end

  if !square
    square = 5 if brd[5] == INITIAL_MARKER
  end

  if !square
    square = empty_squares(brd).sample
  end
  brd[square] = COMPUTER_MARKER
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

def find_at_risk_square(line, brd, marker)
  if brd.values_at(*line).count(marker) == 2
    brd.select {|k,v| line.include?(k) && v == INITIAL_MARKER}.keys.first
  else
    nil
  end
end


loop do
  scores = {human: 0, computer: 0}
  first_player = ''
  choice = ''
  
  if FIRST == 'choose'
    loop do
      system 'clear'
      prompt "*** TIC TAC TOE v1.2 ***"
      prompt 'Who goes first? (h) human or (c) computer'
      choice = gets.chomp.downcase
      break if choice == 'c' || choice == 'h'
      prompt "Invalid choice try again."
    end
  elsif FIRST == 'player'
    choice = 'h'
  elsif FIRST == 'computer'
    choice = 'c'
  end
  
  loop do
    board = initialize_board

    loop do
      if choice == 'h'
        display_board(board)
        prompt "Player: #{scores[:human]} | Computer: #{scores[:computer]} "
        player_places_piece(board)
        break if board_full?(board) || someone_won?(board)
        computer_places_piece(board)
        break if board_full?(board) || someone_won?(board)
      elsif choice == 'c'
        computer_places_piece(board)
        display_board(board)
        prompt "Player: #{scores[:human]} | Computer: #{scores[:computer]} "
        break if board_full?(board) || someone_won?(board)
        player_places_piece(board)
        break if board_full?(board) || someone_won?(board)
      end
    end

    update_score(scores, board) if someone_won?(board)
    
    display_board(board)
    prompt "Player: #{scores[:human]} | Computer: #{scores[:computer]} "
    
    break if scores[:human] == 5 || scores[:computer] == 5
  end
  

  prompt "Play again? (y or n)"
  answer = gets.chomp
  
  break unless answer.downcase.start_with?('y')
end

prompt "thanks for playing tic tac toe"
