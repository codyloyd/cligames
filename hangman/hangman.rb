# lets play HANGMAN 
class Hangman
require "yaml"

  attr_accessor :round_over
  def initialize
    @word_list = File.open("5desk.txt", "r").readlines
    @game_over = false
    @score = 0
  end

  def select_word_from_list(word_list)
    word = word_list[rand(word_list.length)]
    if !word.length.between?(7,14)
      select_word_from_list(word_list)
    else
      word
    end
  end

  def word_to_array(word)
    new_word = word.scan(/./)
    new_word[0].downcase!
    new_word = new_word[0..-2]
  end

  def create_answer_array(word)
    answer_array = []
    word.length.times do
      answer_array.push("_")
    end
    answer_array
  end
  
  def get_response
    puts "Enter a letter"
    letter = gets.chomp.downcase
    check_response(letter)
  end

  def check_response(letter)
    correct_response = false
    if letter == "save"
      save_game
      @game_over = true
    elsif @used_letters.include?(letter)
      puts "you already tried that one, try again"
      return get_response
    end
    @word.each_with_index do |l,i|
      if letter == l 
        @answer_array[i] = letter
        correct_response = true
      end 
    end
    unless correct_response 
      @used_letters.push(letter)
      @turns_remaining -= 1
      puts "uh oh! that letter is not in the puzzle!"
    end
  end

  def take_turn
    system "clear"
    puts "score: #{@score}        #{@turns_remaining} turns remaining"
    puts "your answer so far:"
    puts @answer_array.join(" ")
    unless @used_letters.empty?
      puts "you've already guessed these letters: \n #{@used_letters.join(", ")}"
    end
    puts "please guess a letter."
    get_response
    if @turns_remaining == 0
      puts "YOU LOSE!  THE WORD YOU WERE LOOKING FOR IS \"#{@word.join("")}\" "
      @round_over = true
      @score -= 20
    elsif @answer_array == @word
      puts "YOU ARE THE CHAMPION.  THE WORD \"#{@word.join("")}\" WAS NO MATCH FOR YOU"
      @round_over = true 
      @score += @turns_remaining*10
    end
  end

  def set_up_new_round
    @word = word_to_array(select_word_from_list(@word_list))
    @answer_array = create_answer_array(@word)
    @used_letters = []
    @round_over = false
    @turns_remaining = 6
  end

  def play_game
    puts "Welcome!"
    if File.file?("save.yml")
      puts "would you like to load a previous game? y/n"
      if gets.chomp.downcase == "y"
        load_game
        game_loaded = true
      end
    end  
    until @game_over
      unless game_loaded
        set_up_new_round
      end
      puts "- - - - - - - - - -"
      puts "your score is #{@score}"
      puts "- - - - - - - - - -"
      puts "ready to go? (Y/N)"
      response = gets.chomp
      if response.downcase == "y"
        system "clear"
        until @round_over
          take_turn
        end
        game_loaded = false
      else        
        @game_over = true
      end
    end
  end

  def save_game
    save_hash = {
      :score => @score,
      :word => @word,
      :answer_array => @answer_array,
      :turns_remaining => @turns_remaining,
      :used_letters => @used_letters
    }
    File.open("save.yml", "w") { |f| f.write(save_hash.to_yaml)}
  end

  def load_game
    load_hash = YAML.load(File.open("save.yml"))
    @score = load_hash[:score]
    @word = load_hash[:word]
    @answer_array = load_hash[:answer_array]
    @turns_remaining = load_hash[:turns_remaining]
    @used_letters = load_hash[:used_letters]
  end
  
end
game = Hangman.new
game.play_game