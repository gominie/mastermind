secret_code = [1, 2, 3, 4]
my_guess = [2, 4, 6, 7]


my_guess.each_with_index do |num,index|
  if secret_code[index] == my_guess[index]
    puts "color and position match for #{num} at #{index}"
  elsif secret_code.include?(num)
    puts "found a match for #{num} at a different position"
  else
    puts "No match"
   end
end

#allowed to input and run code 6 times
