# calculator_from_lecture.rb
# 1. string interpolation vs concat
# 2. extract repetitive logic to methods
# 3. keep track of variable types (class)
# 4. variable scope determined by do...end; outer scope vars are available to inner scope, but not vice versa
# 5. pass by ref vs pass by value; if method mutates caller, outer object was modified

puts "This was from the lecture."

def say(msg)
  puts "=> #{msg}"
end

def out_phrase(n1, n2, op)
  "#{n1} #{op} #{n2} ="
end
say "You are running a basic calculator."
say("What's the first number?")
num1 = gets.chomp.to_f
#say("The first number is #{num1}")

say "1) add 2) subtract 3) multiply 4) divide 5) exponent"
operator = gets.chomp.to_i

say("What's the second number?")
num2 = gets.chomp.to_f
#say("The first number is #{num2}")


case operator
when 1
  say "#{out_phrase(num1, num2,"+")} #{num1+num2}"
when 2
  say "#{out_phrase(num1, num2,"-")} #{num1-num2}"
when 3
  say "#{out_phrase(num1, num2,"*")} #{num1*num2}"
when 4
  say "#{out_phrase(num1, num2,"/")} #{num1/num2}"
when 5
  say "#{out_phrase(num1, num2,"^")} #{num1**num2}"
else
  say "Unknown operation selected."
end