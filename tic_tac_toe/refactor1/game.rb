require "./player"

class Game
	attr_accessor :player_1, :player_2, :game_array, :winner

	def initialize
		empty_board
		@solution_array = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
		@winner = nil
	end

	def empty_board
		@game_array = Array.new(9, " ")
	end

	def create_players(p1,p2)
		@player_1 = Player.new(name: p1,marker: "X")
		@player_2 = Player.new(name: p2,marker: "O")
	end

	def print_board
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
	end

	def check_response(response)
		if response.to_i.between?(1,9)
			if game_array[response.to_i-1] == " "
				return {validity: true}
			else
				return {validity: false, msg: "That space is taken, try again"}
			end
		else
			return {validity: false, msg: "invalid response (try a number, 1-9)"}
		end
	end

	def enter_play(args)
			game_array[args[:square].to_i-1] = args[:player].marker
	end

	def game_over?
		if game_array.select.include?(" ")
			@solution_array.each do |sol|
				if game_array[sol[0]] == "X" && game_array[sol[1]] == "X" && game_array[sol[2]] == "X"
					self.winner = player_1
					return true
				elsif game_array[sol[0]] == "O" && game_array[sol[1]] == "O" && game_array[sol[2]] == "O"
					self.winner = player_2
					return true
				end
			end
		else
			return true
		end
		return false
	end
end
