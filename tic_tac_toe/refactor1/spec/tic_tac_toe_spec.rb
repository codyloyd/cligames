require_relative "./tic_tac_toe_refactor1/game"

describe "tic tac toe" do
  subject(:game) {GameBoard.new}
  describe "empty_board" do
    it "creates a 9 element array" do
      game.empty_board
      expect(game.game_array).to eql([" "," "," "," "," "," "," "," "," "])
    end
  end
  describe "check_response" do
    it "returns a hash" do
      game.empty_board
      expect(check_response(1)[:validity]).to eql(true)
    end
  end
end
