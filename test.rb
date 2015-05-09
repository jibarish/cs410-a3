require_relative 'reference'

reference = Reference.new

puts reference.name("0010")
puts reference.majorCategory("0010")
puts reference.category("0010")

puts reference.name("01A2")  # This should return the correction alias
