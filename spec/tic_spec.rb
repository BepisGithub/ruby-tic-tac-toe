require './spec/spec_helper'
require './script'

describe Game do
  describe 'win conditions' do
    first_player = Player.new('dave')
    second_player = Player.new('jones')
    game = Game.new(first_player, second_player)
    
    describe 'horizontal win conditions' do
      it 'wins when there are 3 same horizontal pieces on the top' do
        hash = {'top' => ['x', 'x', 'x'], 'mid' => [' ', ' ', ' '], 'bot' => [' ', ' ', ' ']}
        expect(game.h_winner?(hash)).to be_truthy
      end

      it 'wins when there are 3 same horizontal pieces on the middle' do
        hash = {'top' => [' ', ' ', ' '], 'mid' => ['x', 'x', 'x'], 'bot' => [' ', ' ', ' ']}
        expect(game.h_winner?(hash)).to be_truthy
      end

      it 'wins when there are 3 same horizontal pieces on the bottom' do
        hash = {'top' => [' ', ' ', ' '], 'mid' => [' ', ' ', ' '], 'bot' => ['x', 'x', 'x']}
        expect(game.h_winner?(hash)).to be_truthy
      end

      it 'doesnt win where the board is occupied with different pieces' do
        hash = {'top' => ['x', 'y', 'z'], 'mid' => ['a', 'b', 'c'], 'bot' => ['1', '2', '3']}
        expect(game.h_winner?(hash)).to be false
      end
    end

    describe 'vertical win conditions' do
      it 'wins when there are 3 same vertical pieces in the first row' do
        hash = {'top' => ['x', ' ', ' '], 'mid' => ['x', ' ', ' '], 'bot' => ['x', ' ', ' ']}
        expect(game.v_winner?(hash)).to be_truthy
      end

      it 'wins when there are 3 same vertical pieces in the second row' do
        hash = {'top' => [' ', 'x', ' '], 'mid' => [' ', 'x', ' '], 'bot' => [' ', 'x', ' ']}
        expect(game.v_winner?(hash)).to be_truthy
      end

      it 'wins when there are 3 same vertical pieces in the third row' do
        hash = {'top' => [' ', ' ', 'x'], 'mid' => [' ', ' ', 'x'], 'bot' => [' ', ' ', 'x']}
        expect(game.v_winner?(hash)).to be_truthy
      end

      it 'doesnt win where the board is occupied with different pieces' do
        hash = {'top' => ['x', 'y', 'z'], 'mid' => ['a', 'b', 'c'], 'bot' => ['1', '2', '3']}
        expect(game.v_winner?(hash)).to be false
      end
    end
    # hash = {'top' => [' ', ' ', ' '], 'mid' => [' ', ' ', ' '], 'bot' => [' ', ' ', ' ']}

    describe 'diagonal win conditions' do
      it 'wins when going from top left to bottom right' do
        hash = {'top' => ['x', ' ', ' '], 'mid' => [' ', 'x', ' '], 'bot' => [' ', ' ', 'x']}
        expect(game.d_winner?(hash)).to be_truthy
      end
      it 'wins when going from top right to bottom left' do
        hash = {'top' => [' ', ' ', 'x'], 'mid' => [' ', 'x', ' '], 'bot' => ['x', ' ', ' ']}
        expect(game.d_winner?(hash)).to be_truthy
      end
      it 'doesnt win where the board is occupied with different pieces' do
        hash = {'top' => ['x', 'y', 'z'], 'mid' => ['a', 'b', 'c'], 'bot' => ['1', '2', '3']}
        expect(game.d_winner?(hash)).to be false
      end
    end

    describe 'works with x and y' do
      it 'works with o or any other symbol' do
        hash = {'top' => ['o', 'o', 'o'], 'mid' => ['o', 'o', 'o'], 'bot' => ['o', 'o', 'o']}
        expect(game.h_winner?(hash)).to be_truthy
        expect(game.v_winner?(hash)).to be_truthy
        expect(game.d_winner?(hash)).to be_truthy
      end
    end
  end
end

describe Board do
  # game.board.map = [[" "," "," "], [" "," "," "], [" "," "," "]]

  describe '#draw' do
    it 'occupies a slot at the given coords' do
    board = Board.new
      board.draw(0, 0, 'x')
      expect(board.instance_variable_get(:@map)).to eq([["x"," "," "], [" "," "," "], [" "," "," "]])
    end
    it 'doesnt override an occupied slot' do
      board = Board.new
      board.draw(0, 0, 'x')
      expect(board.draw(0, 0, 'o')).to eq('Error')
    end
  end

  describe '#empty_spaces' do
    it 'shows the whole board if all spaces are empty' do
      board = Board.new
      expect(board.empty_spaces).to eq([[0, 0], [0, 1], [0, 2], [1, 0], [1, 1], [1, 2], [2, 0], [2, 1], [2, 2]])
    end
    it 'returns an error if there are no empty spaces' do
      board = Board.new
      board.instance_variable_set(:@map, [['o', 'o', 'o'], ['o', 'o', 'o'], ['o', 'o', 'o']])
      expect(board.empty_spaces).to eq('Error')
    end
  end

end