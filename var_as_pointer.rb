#Variables as Pointers
#Note: I'm sure I could create a module or something to include the following
#But as of right now (12/22/2014) I don't know exactly how to do that.
def exercise(num)
  puts "------Exercise #{num}------"
end

def answer(val)
  puts "Answer is: #{val}"
end

def question(val)
  puts "Question: #{val}"
end

exercise("Variables as Pointers")
exercise(1)
answer("b evaluates to 'hi_there' because variables point at a place in memory.  Thus when b = a is coded, b is really just pointing to the value at the location a is already assigned to, creating another place in memory with the same value as a.")
answer("Thus, when .gsub! is called on the object, it modifies the specific location where a points to, which is also where b points to.")
a1 = 'hi there'
b1 = a1
a1.gsub!(' ', '_')
puts "puts b prints: #{b1}"

exercise(2)
answer("b should still be 'hi there'")
a2 = 'hi there'
b2 = a2
a2 = [1,2,3]
puts b2

question("What's the difference between the two code examples?")
answer("In the first example, gsub! mutates the caller a and assigns a new value, but that's after b is already assigned to the location of 'hi there'.  Since the mutate the caller method goes to that location, it modifies that value for both a and b.")
answer("In the second example a is directly assigned a new value, which happens to be the array #{a2}, which is now a different location than 'hi there'.")
