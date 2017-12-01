require 'connect_four'

describe Player do
  let(:my_player) do
    Player.new('player1', 'R')
  end

  describe 'initialize' do
    context 'given a new instance of class Player, Player.name' do
      it "returns the player's name" do
        expect(my_player.name).to eql('player1')
      end
    end

    context 'given a new instance of class Player, Player.symbol' do
      it "returns the player's symbol" do
        expect(my_player.symbol).to eql('R')
      end
    end
  end
end

describe Board do
  let(:my_board) do
    Board.new
  end

  let(:my_player) do
    Player.new('player1', 'R')
  end

  describe 'initialize' do
    context 'given a new instance of class Board, Board.spaces.length' do
      it "returns the board's size" do
        expect(my_board.spaces.length).to eql(42)
      end
    end
  end

  describe '#update_board' do
    context 'given player1 and space to move as 10' do
      before do
        my_board.update_board(my_player, 10)
      end
      it "returns 'R' for space 10 on the board" do
        expect(my_board.spaces[10]).to eql('R')
      end
    end
  end

  describe '#undo_move' do
    context 'given space to undo as 10' do
      before do
        my_board.undo_move(10)
      end
      it "returns '-' for space 10 on the board" do
        expect(my_board.spaces[10]).to eql('-')
      end
    end
  end
end
