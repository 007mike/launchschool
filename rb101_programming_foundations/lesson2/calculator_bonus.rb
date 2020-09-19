require 'yaml'
MESSAGES = YAML.load_file('messages.yaml')
LANG = 'es'

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_integer?(input)
  input.to_i().to_s() == input
end

def valid_float?(input)
  input.to_f().to_s() == input
end

def valid_number?(input)
  valid_float?(input) || valid_integer?(input)
end

def operation_to_message(op)
  op_word =   case op
              when '1'
                "Adding"
              when '2'
                "Subtracting"
              when '3'
                "Multiplying"
              when '4'
                "Dividing"
              end
  op_word
end

prompt(MESSAGES[LANG]['welcome'])

name = ''
loop do
  name = Kernel.gets().chomp()
  if name.empty?()
    prompt(MESSAGES[LANG]['name_valid'])
  else
    break
  end
end

prompt("Hi, #{name}")

loop do
  number1 = ''
  loop do
    prompt(MESSAGES[LANG]['first_number'])
    number1 = Kernel.gets().chomp()

    if valid_number?(number1)
      break
    else
      prompt(MESSAGES[LANG]['number_not_valid'])
    end
  end

  number2 = ''
  loop do
    prompt(MESSAGES[LANG]['second_number'])
    number2 = Kernel.gets().chomp()

    if valid_number?(number2)
      break
    else
      prompt(MESSAGES[LANG]['number_not_valid'])
    end
  end

  prompt(MESSAGES[LANG]['operator_choice'])
  operator = ''
  loop do
    operator = Kernel.gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(MESSAGES[LANG]['operator_valid'])
    end
  end

  result =  case operator
            when '1'
              number1.to_i() + number2.to_i()
            when '2'
              number1.to_i() - number2.to_i()
            when '3'
              number1.to_i() * number2.to_i()
            when '4'
              number1.to_f() / number2.to_f()
            end
  prompt("#{operation_to_message(operator)} the two numbers")
  prompt("The result is #{result}")
  prompt(MESSAGES[LANG]['try_again'])
  continue = Kernel.gets().chomp()
  break unless continue.downcase().start_with?('y')
end

prompt(MESSAGES[LANG]['thank_you'])
