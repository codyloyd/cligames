require "./game.rb"
game = Game.new
puts "Player 1, please enter your name"
p1 = gets.chomp
puts "Player 2, please enter your name"
p2 = gets.chomp
game.create_players(p1,p2)
game.print_help

player = game.player_1

until game.game_over? do
  game.print_board
  puts "#{player.name}, please enter your play."
  computer_reply = game.check_response(gets.chomp,player)
  if computer_reply
    puts computer_reply
    redo
  end
	break if game.game_over?
  player == game.player_1 ? player = game.player_2 : player = game.player_1
end

puts "game over"

# puts "#{@player_1.name.upcase} WINS..." + " #{@player_2.name.upcase} is a LOSER"
# puts "#{@player_2.name.upcase} WINS..." + " #{@player_1.name.upcase} is a LOSER"
#
# puts "It's a draw!"
