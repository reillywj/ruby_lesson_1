# variable_scope.rb
# Read secion on variable scope
# Play around

def exercise(num)
  puts "------Exercise #{num}------"
end

def answer(val)
  puts "Answer is: #{val}"
end

exercise("1a")
answer("x is now 'hey there'")

exercise('1b')
answer("output is =>[1, 2, 2, 3], the original my_arr because .uniq does not mutate arr, which is scoped within the method.")

exercise('1c')
answer("output is =>[1,2,3] since .uniq! mutates the caller")

exercise('2')
puts "my_arr = [1,2,3]"
puts "my_arr.each {|n| my_local_variable = n}"
puts "puts my_local_variable.to_s"
answer("=>Returns undefined local variable or method for main:Object (NameError)")

test_variable = 55
loop do
  test_variable = test_variable / 11
  break
end
puts test_variable

def yes_mutate(arr)
  arr.pop
  arr.shift
end
def no_mutate(arr)
  arr.size
end
my_arr = ["To be shifted", 1,2,3,4,"To be popped off"]
puts "value no_mutate returns: #{no_mutate(my_arr)}"
puts "my_arr before: #{my_arr}"
yes_mutate(my_arr)
puts "my_arr after yes_mutate: #{my_arr}"
puts "value no_mutate returns: #{no_mutate(my_arr)}"
yes_mutate(my_arr)
puts "my_arr after yes_mutate again: #{my_arr}"
puts "value no_mutate returns: #{no_mutate(my_arr)}"
yes_mutate(my_arr)
puts "my_arr after yes_mutate yet again: #{my_arr}"
puts "value no_mutate returns: #{no_mutate(my_arr)}"
no_mutate(my_arr)
puts "my_arr after no_mutate #{my_arr}"
puts "value no_mutate returns: #{no_mutate(my_arr)}"

exercise(3)
answer("should be an error saying no input was passed to the my_method method.")
# x = "hi"
# def my_method
#   puts x
# end
# my_method
answer("Additionally after running to get the error: not only was a variable not passed, but the variable x ---scoped within my_method--- is a local variable that has not been passed a value.")