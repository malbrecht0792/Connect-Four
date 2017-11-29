module ConnectFour
  class Game
    def initialize(player1_name, player2_name)
      @player1 = Player.new(player1_name, 'R')
      @player2 = Player.new(player2_name, 'Y')
      @board = Board.new
    end
  end

  class Player
    attr_accessor :name, :symbol

    def initialize(name, symbol)
      @name = name
      @symbol = symbol
    end
  end

  class Board
    attr_accessor :spaces

    def initialize
      @spaces = ['-', '-', '-', '-', '-', '-', '-',
                 '-', '-', '-', '-', '-', '-', '-',
                 '-', '-', '-', '-', '-', '-', '-',
                 '-', '-', '-', '-', '-', '-', '-',
                 '-', '-', '-', '-', '-', '-', '-',
                 '-', '-', '-', '-', '-', '-', '-']
    end
  end
end

include ConnectFour

Game.new('Player 1', 'Player 2')
