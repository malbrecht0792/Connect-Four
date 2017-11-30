require 'connect_four'

describe Player do
  let (:my_player) do
    Player.new('player1', 'X')
  end

  describe 'initialize' do
    context 'given a new instance of class Player, Player.name' do
      it "returns the player's name" do
        expect(my_player.name).to eql('player1')
      end
    end

    context 'given a new instance of class Player, Player.symbol' do
      it "returns the player's symbol" do
        expect(my_player.symbol).to eql('X')
      end
    end
  end
end
