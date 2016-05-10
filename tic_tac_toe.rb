class GameBoard
	attr_accessor :player_1, :player_2, :game_over
	
	def initialize
		empty_board
		create_players
		help
		@solution_array = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
		@game_over = false
	end
	
	def empty_board
		@game_array = []
		9.times {@game_array.push(" ")}
	end

	def create_players
		puts "Player 1, please enter your name"
		@player_1 = Player.new(gets.chomp)  
		puts "Player 2, please enter your name"
		@player_2 = Player.new(gets.chomp)  
	end

	def print_board
		system "clear"
		puts " #{@game_array[0]} | #{@game_array[1]} | #{@game_array[2]} "
		puts "---+---+---"
		puts " #{@game_array[3]} | #{@game_array[4]} | #{@game_array[5]} "
		puts "---+---+---"
		puts " #{@game_array[6]} | #{@game_array[7]} | #{@game_array[8]} "
	end

	def help
		puts "select a square by entering one"
		puts "of the following numbers:"
		puts
		puts " 1 | 2 | 3 "
		puts "---+---+---"
		puts " 4 | 5 | 6 "
		puts "---+---+---"
		puts " 7 | 8 | 9 "
		puts
		puts "#{@player_1.name} is X, #{@player_2.name} is O"
		puts
		print_board
	end

	def input(player)
		puts "#{player.name}, please enter your play."
		response = gets.chomp
		if response.to_i.between?(1,9) 
			if @game_array[response.to_i-1] == " "
				enter_play(player,response)
			else
				puts "That space is taken, try again"
				input(player)
			end
		else
			puts "invalid response (try a number, 1-9)"
			input(player)
		end
	end


	def enter_play(player,square)
		if player == @player_1
			@game_array[square.to_i-1] = "X"
		else
			@game_array[square.to_i-1] = "O"
		end
		print_board
		game_over?
	end

	def game_over?
		if @game_array.select.include?(" ")
			@solution_array.each do |sol|
				if @game_array[sol[0]] == "X" && @game_array[sol[1]] == "X" && @game_array[sol[2]] == "X"
					puts "#{@player_1.name.upcase} WINS... #{@player_2.name.upcase} is a LOSER"
					@game_over = true
				elsif @game_array[sol[0]] == "O" && @game_array[sol[1]] == "O" && @game_array[sol[2]] == "O"
					puts "#{@player_2.name.upcase} WINS... #{@player_1.name.upcase} is a LOSER"
					@game_over = true
				end
			end
		else
			puts "It's a draw!"
			@game_over = true
		end
	end

	class Player
		attr_accessor :name
		def initialize(name)
			@name = name
		end
	end
end

game = GameBoard.new

until game.game_over do
	game.input(game.player_1)
	break if game.game_over
	game.input(game.player_2)
end

