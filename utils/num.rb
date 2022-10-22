# Trying to manually convert numbers to binary - too much of a mess, easier to just check boundary and flip bit

max = ((2 ** 31) - 1)
min = -((2 ** 31))
w = -1
x = 1
y = -2
z = 2

puts "#{w} in binary is #{31.downto(0).map { |n| w[n] }.join}"
puts "#{x} in binary is #{31.downto(0).map { |n| x[n] }.join}"
puts "#{y} in binary is #{31.downto(0).map { |n| y[n] }.join}"
puts "#{z} in binary is #{31.downto(0).map { |n| z[n] }.join}"
puts "#{max} in binary is #{31.downto(0).map { |n| max[n] }.join}"
puts "#{max} inv binary is #{31.downto(0).map { |n| max[n] }.join}"
puts "#{min} in binary is #{31.downto(0).map { |n| min[n] }.join}"
