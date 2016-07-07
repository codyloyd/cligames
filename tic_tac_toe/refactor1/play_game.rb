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
  user_play = gets.chomp
  if game.check_response(user_play)[:validity]
    game.enter_play(player: player,square: user_play)
  else
    puts game.check_response(user_play)[:msg]
    redo
  end
  player == game.player_1 ? player = game.player_2 : player = game.player_1
end

game.print_board
puts "game over"
if game.winner
  puts "#{game.winner.name} is the winner!"
else
  puts "it seems to be a tie...."
end
