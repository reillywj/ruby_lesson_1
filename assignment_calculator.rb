#assignment_calculator.rb
require 'pry'

#Note: Use only local variables.

#Goal
#Basic calculator
#Takes in two numbers
#Asks for an operation to perform on them
#Returns the value
#Continue to ask if there's more to be calculated
#Calc if yes
#Say goodbye and end loop if no

def ask_for_initial_number(phrase)
  print "Please enter the #{phrase}: "
  gets.chomp.to_f
end

def ask_for_operation(hash)
  print "1-Plus, 2-Minus, 3-Times, 4-Divided by, 5-To the Power of: "
  requested_operation = gets.chomp
  if hash.has_key?(requested_operation)
    return requested_operation
  else
    tell_invalid("option. Try again: ")
    ask_for_operation(hash)
  end
end

operator_hash = {"1"=>'+', "2"=>'-', "3"=>'*', "4"=>'/', "5"=>'**'}

def ask_for_final_number(number1 = "", operation ="")
  if ((number1 == "") || (operation == ""))
    print "Please enter your final number:"
  else
    print "#{number1} #{operation} <Enter Final Number>: "
  end
  gets.chomp.to_f
end

def tell_invalid(message)
  print "Invalid #{message}"
end

def something_else?(action)
  print "Do you want to #{action} something else? (Y/N): "
  result = gets.chomp
  if ["Y", "y", "N", "n"].include?(result)
    if (result == "Y") || (result == "y")
      return true
    else
      return false
    end
  else
    tell_invalid("input. Must be Y or N. ")
    something_else?(action)
  end
end

loop_truth = true
loops = 0
loop_limit = 10

begin
  number1 = ask_for_initial_number("first number")
  operation = ask_for_operation(operator_hash)
  operator = operator_hash[operation]
  number2 = ask_for_final_number
  puts "#{number1} #{operator} #{number2} = #{number1.send(operator,number2)}"
  loop_truth = something_else?("calculate")
  loops += 1
end while (loop_truth && loops < loop_limit)

if loops < loop_limit
  puts "Thank you for using this calculator. Have a nice day!"
else
  puts "#{loop_limit} is the per use limit of this calculator. This is not the right calculator for your needs."
end





