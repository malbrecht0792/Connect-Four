module ConnectFour
  class Game
    def initialize(player1_name, player2_name)
      @player1 = Player.new(player1_name, 'R')
      @player2 = Player.new(player2_name, 'Y')
      @board = Board.new
      @current_player = @player1
      @continue_game = true
      game_loop
    end

    def game_loop
      turn while @continue_game
    end

    def turn
      puts "#{@current_player.name}, please select a slot (1-7)."
      @slot_to_move = gets.chomp.to_i
      find_space_to_move
      @board.update_board(@current_player, @space_to_move)
      @board.display_board
    end

    def find_space_to_move
      index_array = [35, 28, 21, 14, 7, 0]

      index_array.each do |index|
        @space_to_move = index + (@slot_to_move - 1)
        return if @board.spaces[@space_to_move] == '-'
      end
      puts 'This slot is full! Please select a different slot.'
      @slot_to_move = gets.chomp.to_i
      find_space_to_move
    end

    def check_space_to_move
      @board.spaces[@space_to_move] == '-'
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

    def update_board(current_player, space_to_move)
      @spaces[space_to_move] = current_player.symbol
    end

    def display_board
      print "\n"
      @spaces.each_with_index do |_space, index|
        if [6, 13, 20, 27, 34].include? index
          print @spaces[index] + "\n"
        else
          print @spaces[index] + ' '
        end
      end
      print "\n\n"
    end
  end
end

include ConnectFour

Game.new('Player 1', 'Player 2')
