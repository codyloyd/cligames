require "./game.rb"
game = Game.new

puts "Player 1, please enter your name"
p1 = gets.chomp
puts "Player 1, please enter your name"
p2 = gets.chomp
game.create_players(p1,p2)
game.print_help

player = game.player_1
until game.game_over do
  puts "#{player.name}, please enter your play."
  response = gets.chomp
  game.check_response(response,player)
	break if game.game_over
end


puts "#{@player_1.name.upcase} WINS..." + " #{@player_2.name.upcase} is a LOSER"
puts "#{@player_2.name.upcase} WINS..." + " #{@player_1.name.upcase} is a LOSER"

puts "It's a draw!"
