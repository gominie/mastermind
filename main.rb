secret_code = [1, 2, 3, 4]
my_guess = [2, 4, 6, 7]

class Mastermind
  attr_reader :gen_code
  def initialize
    @secret_code = []
    @guess = []
    @victory = false
    @guess_count = 0
    @hint_arr = []
    @play_mode = 0
  end


  def create_secret_code
    #numbers = (0..6).to_a
    @gen_code = (0..6).to_a.shuffle.take(4)
    @secret_code = @gen_code
    #p "secret code is: #{@secret_code}"
  end

  def victory?
    if @guess == @secret_code
      @victory = true
      p "You have won!"
    end
  end

  def code_breaker
    p "Play mode 2 starts"
    create_secret_code
    while !@victory && @guess_count < 6
      puts "What's the code? #{6-@guess_count} guesses remaining"
      @guess = gets.chomp.to_i.digits.reverse
      next unless @guess.length == 4 && @guess.all? { |num| (0..6).include?(num) }
      @guess_count += 1
      break if victory?
      #puts "Guess Count: #{@guess_count}"
      handle_guess if @guess_count < 6
      puts 'Out of guesses' if @guess_count == 6 && !victory?
    end
  end

  def code_maker
    puts "Please input code"
    create_secret_code
    @secret_code = gets.chomp.to_i.digits.reverse
    @guess = @gen_code
    p "guess is: #{@guess}"
    p "secret code is: #{@secret_code}"
    #while !victory?
    #@guess = (0..6).to_a.shuffle.take(4)

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
    puts 'Welcome to terminal mastermind!'
    puts "Press 1 to be a code maker and 2 to be a code breaker"
    @play_mode = gets.chomp.to_i
    while !(@play_mode == 1 || @play_mode == 2)
      puts "Invalid play mode. Please enter 1 or 2"
      @play_mode = gets.chomp.to_i
    end
    if @play_mode == 2
    code_breaker
    elsif @play_mode == 1
      code_maker
    end
  end
end

game = Mastermind.new
game.start_game

#need put play modes in own methods

=begin
p "Play mode 2 starts"
create_computer_guess
while !@victory && @guess_count < 6
  puts "What's the code? #{6-@guess_count} guesses remaining"
  @guess = gets.chomp.to_i.digits.reverse
  next unless @guess.length == 4 && @guess.all? { |num| (0..6).include?(num) }

  @guess_count += 1
  break if victory?

  puts "Guess Count: #{@guess_count}"
  handle_guess
  puts 'Out of guesses' if @guess_count == 6 && !victory?
end
elsif @play_mode == 1
 p "need input code"
=end
