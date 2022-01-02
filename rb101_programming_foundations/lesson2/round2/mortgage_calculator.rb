# mortgage_calculator.rb

def prompt(str)
  puts ">> #{str}"
end

def monthly_payment(loan_amount, mpr, loan_months)
  loan_amount * (mpr / (1 - (1 + mpr)**(-loan_months)))
end

prompt("Welcome to the Loan Payment Calculator")

loop do
  prompt("What is the amount of the loan?")

  loan_amount = ''

  loop do
    loan_amount = gets.chomp.to_f
    break if loan_amount > 0
    prompt("Amount must be a number greater than 0.")
  end

  annual_percentage_rate = ''

  prompt("What is the APR%?")

  loop do
    annual_percentage_rate = gets.chomp.to_f
    break if annual_percentage_rate > 0
    prompt("APR must be a number greater than 0.")
  end

  loan_duration_months = ''

  prompt("What is the loan duration in months?")

  loop do
    loan_duration_months = gets.chomp.to_i
    break if loan_duration_months > 0
    prompt("Invalid duration length. Try again.")
  end

  monthly_percentage_rate = annual_percentage_rate / 12 / 100

  payment = monthly_payment(loan_amount,
                            monthly_percentage_rate,
                            loan_duration_months)

  prompt("Your monthly payment is $#{format('%.2f', payment)}")

  prompt("Perform another calculation? Press Y to continue.")
  continue = gets.chomp.downcase

  break if continue != 'y'
end

prompt("Thank you for using the Loan Payment Calculator.")
