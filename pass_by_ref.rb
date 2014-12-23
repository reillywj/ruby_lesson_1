#pass_by_ref.rb
def exercise(num)
  puts "------Exercise #{num}------"
end

def answer(val)
  puts "Answer is: #{val}"
end


def my_method(arr)
  arr.uniq
end
exercise("Pass by reference vs value (not as part of lecture)")
my_arr = [1,2,2,3]
my_method(my_arr)
puts my_arr.to_s
answer("This is a method that does not mutate the calling object.  It does not affect the array outside the method.  If the method is changed to uniq! instead of just uniq, it will mutate the caller and affect my_arr after it is passed to this method.")
