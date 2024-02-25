secret_code = [1, 2, 3, 4]
my_guess = [2, 4, 6, 7]

class Mastermind
  def initialize
    @secret_code = []
    @guess = []
    @victory = false
    @guess_count = 0
    @hint_arr = []
  end

  def create_computer_guess
    numbers = (1..6).to_a
    @secret_code = numbers.shuffle.take(4)
    #p "secret code is: #{@secret_code}"
  end

  def victory?
    if @guess == @secret_code
      @victory = true
      p "You have won!"
    end
  end

  def handle_guess
      hint_arr = []
      @guess.each_with_index do |num, index|
      if @secret_code[index] == @guess[index]
        @hint_arr << "●"
      elsif @secret_code.include?(num)
        @hint_arr << "○"
      end
     end
     @hint_arr.shuffle!
     p "hint: #{@hint_arr.join(" ")}"
     @hint_arr = []
  end


  def start_game
    @secret_code = [1, 2, 4, 4]
    puts "Welcome to terminal mastermind!"
    create_computer_guess
    while (!@victory && @guess_count <= 6)
      result = !@victory || @guess_count <= 6
      @guess = gets.chomp.to_i.digits.reverse
      next unless @guess.length == 4 && @guess.all? {|num| (1..6).include?(num)}
      @guess_count += 1
      break if victory?
      p "Guess Count: #{@guess_count}"
      handle_guess
      if @guess_count == 6 && !victory?
        p "Out of guesses"
       end
    end
  end
end

game = Mastermind.new
game.start_game

#added no victory case
#wat happens i correct on 6th guess
#all array for 1-6
