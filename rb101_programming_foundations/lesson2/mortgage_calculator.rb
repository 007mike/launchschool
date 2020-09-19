# mortgage_calculator.rb
# Inputs: loan amount, annual APR and loan duration (years)
# Calculate: monthly payment, monthly APR, loan duration (months)

def prompt(message)
  puts "==> #{message}"
end

def valid_float?(input)
  (input.to_f.to_s == input) && (input.to_f > 0.0)
end

def valid_integer?(input)
  (input.to_i.to_s == input) && (input.to_i > 0)
end

def valid_number?(input)
  valid_integer?(input) || valid_float?(input)
end

def calculating(numtimes)
  print 'Calculating '
  waitcursor = "."
  numtimes.times do
    print waitcursor
    sleep(0.1)
  end
end

puts "\n**** MORTGAGE CALCULATOR v1.0 ****\n"

loop do
  total_loan_amount = ''
  loop do
    prompt('Enter the loan amount in $')
    total_loan_amount = gets.chomp

    if valid_number?(total_loan_amount)
      break
    else
      prompt("That doesn't look like a proper loan amount. Try again.")
    end
  end

  annual_interest_rate = ''
  loop do
    prompt('Enter the annual interest rate in %')
    annual_interest_rate = gets.chomp

    if valid_number?(annual_interest_rate)
      break
    else
      prompt("That doesn't look like a valid interest rate. Try again.")
    end
  end

  loan_duration_years = ''
  loop do
    prompt('Enter the loan duration in years')
    loan_duration_years = gets.chomp

    if valid_integer?(loan_duration_years)
      break
    else
      prompt("Loan duration must be entered in years. Try again.")
    end
  end

  monthly_interest_rate = (annual_interest_rate.to_f / 100) / 12
  loan_duration_months = loan_duration_years.to_f * 12
  monthly_payment = total_loan_amount.to_f *
                    (monthly_interest_rate /
                    (1 - (1 + monthly_interest_rate)**(-loan_duration_months)))

  puts "\n"
  calculating(10)
  puts "\n"
  prompt("Monthly Payment:\t $#{monthly_payment.round(2)}")
  prompt("No. of Payments:\t #{loan_duration_months.to_i}")
  prompt("Loan Amount:\t $#{format('%.02f', total_loan_amount.to_f)}")
  prompt("Annual APR:\t\t #{annual_interest_rate.to_f.round(2)}%")

  puts "\n"
  prompt("Try again? [Y] for yes.")
  try_again = gets.chomp
  break unless try_again.downcase.start_with?('y')
end

puts "\n**** That's a wrap! Good bye. ****\n\n"
