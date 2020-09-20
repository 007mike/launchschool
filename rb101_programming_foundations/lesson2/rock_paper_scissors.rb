VALID_CHOICES = ['rock', 'paper', 'scissors']

def prompt(message)
  Kernel.puts("=> #{message}")
end

def win?(first, second)
  (first == 'rock' && second == 'scissors') ||
    (first == 'paper' && second == 'rock') ||
    (first == 'scissors' && second == 'paper')
end

def display_results(human, computer)
  if win?(human, computer)
    prompt('You won!')
  elsif win?(computer, human)
    prompt('Computer won!')
  else
    prompt('It was a tie.')
  end
end

loop do
  human_choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    human_choice = Kernel.gets().chomp()

    if VALID_CHOICES.include?(human_choice)
      break
    else
      prompt('You made an incorrect choice. Try again.')
    end
  end

  computer_choice = VALID_CHOICES.sample

  prompt("You chose: #{human_choice}. Computer chose: #{computer_choice}")

  display_results(human_choice, computer_choice)

  prompt('Do you want to play again? [Y] for yes.')
  play_again = gets().chomp()
  break unless play_again.downcase.start_with?('y')
end

prompt('Thanks for playing!')
