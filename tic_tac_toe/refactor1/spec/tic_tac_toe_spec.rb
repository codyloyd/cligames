require "./tic_tac_toe_refactor1"

describe "tic tac toe" do
  subject(:game) {GameBoard.new}
  describe "empty_board" do
    it "creates a 9 element array" do
      game.empty_board
      expect(game.game_array).to eql([" "," "," "," "," "," "," "," "," "])
    end
  end
end
