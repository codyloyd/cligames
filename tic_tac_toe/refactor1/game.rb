require "./player"

class Game
	attr_accessor :player_1, :player_2, :game_over, :game_array

	def initialize
		empty_board
		@solution_array = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
		@game_over = false
	end

	def empty_board
		@game_array = Array.new(9, " ")
	end

	def create_players(p1,p2)
		@player_1 = Player.new(p1,"X")
		@player_2 = Player.new(p2,"O")
	end

	def print_board
		# system "clear"
		puts " #{game_array[0]} " + "|" + " #{game_array[1]} " + "|" + " #{game_array[2]} "
		puts "---+---+---"
		puts " #{game_array[3]} " + "|" + " #{game_array[4]} " + "|" + " #{game_array[5]} "
		puts "---+---+---"
		puts " #{game_array[6]} " + "|" + " #{game_array[7]} " + "|" + " #{game_array[8]} "
	end

	def print_help
		puts "select a square by entering one"
		puts "of the following numbers:"
		puts
		puts " 1 | 2 | 3 "
		puts "---+---+---"
		puts " 4 | 5 | 6 "
		puts "---+---+---"
		puts " 7 | 8 | 9 "
		puts
		puts "#{@player_1.name} is #{@player_1.marker}, #{@player_2.name} is #{@player_2.marker}"
		puts
		print_board
	end

	# def input(player)
	# 	puts "#{player.name}, please enter your play."
	# 	response = gets.chomp
	# 	check_response(response,player)
	# end

	def check_response(response,player)
		if response.to_i.between?(1,9)
			if game_array[response.to_i-1] == " "
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
			game_array[square.to_i-1] = player.marker
			print_board
			game_over?
	end

	def game_over?
		if game_array.select.include?(" ")
			@solution_array.each do |sol|
				if game_array[sol[0]] == "X" && game_array[sol[1]] == "X" && game_array[sol[2]] == "X"
					@game_over = true
				elsif game_array[sol[0]] == "O" && game_array[sol[1]] == "O" && game_array[sol[2]] == "O"
					@game_over = true
				end
			end
		else
			@game_over = true
		end
	end
end
