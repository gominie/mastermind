secret_code = [1, 2, 3, 4]
my_guess = [2, 4, 6, 7]

class Mastermind
  def initialize
    @secret_code = []
    @guess = []
    @victory = false
    @guess_count = 0
  end

  def create_computer_guess
    # fill in later
  end

  def victory?
    if @guess == @secret_code
      @victory = true
    end
  end

  def handle_guess
    @guess.each_with_index do |num, index|
      if @secret_code[index] == @guess[index]
        #puts "color and position match for #{num} at #{index}"
        puts "●"
      elsif @secret_code.include?(num)
        #puts "found a match for #{num} at a different position"
        puts "○"
      else
        puts 'No match'
      end
    end
  end

  #save handle guess reply into array so I can add "hint"
  #before it

  def start_game
    @secret_code = [1, 2, 3, 4]
    while (!@victory && @guess_count <= 6)
      result = !@victory || @guess_count <= 6
      p result
      @guess = gets.chomp.split.map(&:to_i)
      @guess_count += 1
      victory?
      handle_guess
      p "value of victory: #{@victory}"
    end
    p "you have won"
  end
end

game = Mastermind.new
game.start_game

# #workks to iterate through player guess
# my_guess.each_with_index do |num,index|
#   if secret_code[index] == my_guess[index]
#     puts "color and position match for #{num} at #{index}"
#   elsif secret_code.include?(num)
#     puts "found a match for #{num} at a different position"
#   else
#     puts "No match"
#    end
# end
#
# allowed to input and run code 6 times
