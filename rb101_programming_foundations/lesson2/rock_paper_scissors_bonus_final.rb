# paper rock scissors w bonus features

VALID_CHOICES = { r: 'rock',
                  p: 'paper',
                  s: 'scissors',
                  l: 'lizard',
                  v: 'spock' }

WINNING_COMBOS = { rock: ['scissors', 'lizard'],
                   paper: ['rock', 'spock'],
                   scissors: ['paper', 'lizard'],
                   lizard: ['paper', 'spock'],
                   spock: ['rock', 'scissors'] }

HUMAN_WIN_MESSAGE = ["You beat him so bad he wants to quit.",
                     "You won this round bub. Keep it up.",
                     "You slayed the mechanical dragon.",
                     "You seem unbeatable right now.",
                     "Ello ello, that was IMPRESSIVE.",
                     "It's clear... you were born to play this game.",
                     "All those hours training paid off big time!"]

COMPUTER_WIN_MESSAGE = ["Uh oh... Mr. Chips is a crafty one.",
                        "Mr. Chips is your bane right now.",
                        "Keep trying, it can't get worse.",
                        "WTF, it's Mr. Chips with the hail mary!",
                        "Ouch... you better up your game QUICK.",
                        "You're getting too predictable. Change it up.",
                        "I don't need to tell you that was an awful choice."]

def prompt(message)
  Kernel.puts(">> #{message}")
end

def win?(key, value)
  WINNING_COMBOS[key.to_sym].include?(value)
end

def display_results(human, computer)
  if win?(human, computer)
    prompt(HUMAN_WIN_MESSAGE.sample)
  elsif win?(computer, human)
    prompt(COMPUTER_WIN_MESSAGE.sample)
  else
    prompt('It was a tie... how boring :(')
  end
end

def update_score(player1, player2, scores)
  if win?(player1, player2)
    scores[:human] += 1
  elsif win?(player2, player1)
    scores[:computer] += 1
  end
end

def display_loading(numtimes)
  print 'Loading game '
  numtimes.times do
    print '.'
    sleep(0.1)
  end
  print ' Done!'
  sleep(0.3)
end

title_message = <<-MSG


*****************************************
*                                       *
*   PAPER, ROCK, SCISSORS v1.0          *
*   by: Michael Lawrence                *
*                                       *
*****************************************
MSG

loop do
  display_loading(10)
  scores = { human: 0, computer: 0 }
  human_choice = ''
  round = 1

  puts title_message

  loop do
    loop do
      puts "\n***************************"
      prompt("Please make a selection:")
      puts "***************************\n"

      VALID_CHOICES.each do |key, value|
        print "[#{key}] #{value.capitalize} "
      end
      print '=> '

      human_choice = VALID_CHOICES[Kernel.gets().chomp().downcase.to_sym]

      if VALID_CHOICES.value?(human_choice)
        break
      else
        puts "\n"
        prompt("You messed up there. Try again, it's not that hard.")
      end
    end

    computer_choice = VALID_CHOICES.values.sample

    puts "\n"
    prompt("The results for round #{round} are in:")
    prompt("You chose: \t\t--[ #{human_choice.upcase} ]--")
    prompt("Mr. Chips chose: \t--[ #{computer_choice.upcase} ]--")

    puts "\n"
    display_results(human_choice, computer_choice)

    puts "\n"
    update_score(human_choice, computer_choice, scores)
    prompt("Scores: [ YOU: #{scores[:human]} ] " \
         "vs. [ MR. CHIPS: #{scores[:computer]} ] ... in a race to 5.")

    break if (scores[:human] == 5) || (scores[:computer] == 5)
    round += 1
  end

  puts "\n***********************************************"
  print "That's a wrap! Play a new game? [Y] for yes. => "

  play_again = Kernel.gets().chomp()

  break unless play_again.downcase.start_with?('y')
end

end_message = <<-MSG

*****************************************
*                                       *
*   GAME OVER                           *
*   Thanks for playing!                 *
*                                       *
*****************************************

MSG

puts end_message
