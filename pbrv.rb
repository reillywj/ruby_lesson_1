# #pass by value
# #when I have a method
# def someth_method(str)
# return "#{str}. string has been changed"
# end
# #pass by value says you're only passing the string, it's a copy
# outer_str = "hi"
# some_method(outer_str)
# #would have to reset the value
# outer_str = some_method(outer_str)

# #pass by reference
# some_method(outer_str)#this would change the outer_str variable

#what ruby says
def some_method (obj)
  obj.uniq #versus obj.uniq! #if this method/change is a caller method it can affect
  #so it depends on what's in the method on whether it's pass by value or reference.
end
#So need to know what this method is doing and how to use the method in the code
outer_obj = [1,2,2,3,3]
some_method(outer_obj)
puts outer_obj

#Ruby is technically "Passing by value of the reference"