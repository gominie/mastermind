class Mastermind

  def initialize
    @secret_code = []
    @guess = []
    @victory = false
    @guess_count = 0
    @hint_arr = []
    @play_mode = 0
  end

  def create_secret_code
    @gen_code = (0..6).to_a.shuffle.take(4)
    @secret_code = @gen_code
    # p "secret code is: #{@secret_code}"
  end

  def create_computer_guess
    empty_arr = Array.new(4)
    puts "empty arr value before code is #{empty_arr}"
    @guess.each_with_index do |num, index|
      #keep correct guess in same position
      if @guess[index] == @secret_code[index]
        empty_arr[index] = @secret_code[index]
      elsif @secret_code.include?(num)
        #nil values in arr that arent perfect matches
        empty_indexes = empty_arr.each_index.select { |i| empty_arr[i].nil? }
        #get random nil index so only 1 value changed at a time
        random_empty_index = empty_indexes.sample

        new_num = (0..6).to_a.sample
        while @guess.include?(new_num)
          new_num = (0..6).to_a.sample
        end
        empty_arr[random_empty_index] = num
      end
    end
    #any remaining nil values are replaced with random number
    empty_arr.map! {|value| value.nil? ? (0..6).to_a.sample : value}
    @guess = empty_arr
  end


  def victory?
    return unless @guess == @secret_code

    @victory = true
    p 'You have won!'
  end

  def code_breaker
    p 'Play mode 2 starts'
    create_secret_code
    while !@victory && @guess_count < 6
      puts "What's the code? #{6 - @guess_count} guesses remaining"
      @guess = gets.chomp.to_i.digits.reverse
      next unless @guess.length == 4 && @guess.all? { |num| (0..6).include?(num) }
      @guess_count += 1
      break if victory?
      handle_guess if @guess_count < 6
      puts 'Out of guesses' if @guess_count == 6 && !victory?
    end
  end

  def code_maker
    puts 'Please input your secret code of 4 digits using numbers 0-6'
    until @secret_code.length == 4 && @secret_code.all? { |num| (0..6).include?(num) }
      @secret_code = gets.chomp.to_i.digits.reverse
  end
    p "secret code is: #{@secret_code}"
    while !@victory && @guess_count < 6
      if @guess_count == 0
        @guess = (0..6).to_a.shuffle.take(4)
        puts "computer guesses: #{@guess}"
        victory?
        sleep(2)
        handle_guess
        @guess_count += 1
      end
      create_computer_guess
      sleep (2)
      p "guess is: #{@guess}"
      @guess_count += 1
      break if victory?

      handle_guess if @guess_count < 6
      puts 'Out of guesses' if @guess_count == 6 && !victory?
    end
  end

  def handle_guess
    @hint_arr = []

    @guess.each_with_index do |num, index|
      if @secret_code[index] == @guess[index]
        @hint_arr << '●'
      elsif @secret_code.include?(num)
        @hint_arr << '○'
      end
    end
    @hint_arr.shuffle!
    p "hint: #{@hint_arr.join(' ')}"
    #@hint_arr = []
  end

  def start_game
    puts 'Welcome to terminal mastermind!'
    puts 'Press 1 to be a code maker and 2 to be a code breaker'
    @play_mode = gets.chomp.to_i
    until @play_mode == 1 || @play_mode == 2
      puts 'Invalid play mode. Please enter 1 or 2'
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
