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
      declare_winner if check_for_winner
      check_for_no_winner
      change_players
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

    def change_players
      @current_player = @current_player == @player1 ? @player2 : @player1
    end

    def declare_winner
      puts "#{@current_player.name}, you are the winner!"
      @continue_game = false
    end

    def check_for_winner
      all_winning_spaces_array =
        [[35, 28, 21, 14], [28, 21, 14, 7], [21, 14, 7, 0],
         [36, 29, 22, 15], [29, 22, 15, 8], [22, 15, 8, 1],
         [37, 30, 23, 16], [30, 23, 16, 9], [23, 16, 9, 2],
         [38, 31, 24, 17], [31, 24, 17, 10], [24, 17, 10, 3],
         [39, 32, 25, 18], [32, 25, 18, 11], [25, 18, 11, 4],
         [40, 33, 26, 19], [33, 26, 19, 12], [26, 19, 12, 5],
         [41, 34, 27, 20], [34, 27, 20, 13], [27, 20, 13, 6],
         [14, 22, 30, 38],
         [7, 15, 23, 31], [15, 23, 31, 39],
         [0, 8, 16, 24], [8, 16, 24, 32], [16, 24, 32, 40],
         [1, 9, 17, 25], [9, 17, 25, 33], [17, 25, 33, 41],
         [2, 10, 18, 26], [10, 18, 26, 34],
         [3, 11, 19, 27],
         [3, 9, 15, 21],
         [4, 10, 16, 22], [10, 16, 22, 28],
         [5, 11, 17, 23], [11, 17, 23, 29], [17, 23, 29, 35],
         [6, 12, 18, 24], [12, 18, 24, 30], [18, 24, 30, 36],
         [13, 19, 25, 31], [19, 25, 31, 37],
         [20, 26, 32, 38]]
      all_winning_spaces_array.each do |winning_spaces_array|
        all_spaces_true = true
        winning_spaces_array.each do |winning_index|
          all_spaces_true = false unless @board.spaces[winning_index] ==
                                         @current_player.symbol
        end
        return true if all_spaces_true
      end
      false
    end

    def check_for_no_winner
      if @board.spaces.none? { |space| space == '-' }
        puts "It's a tie!"
        @continue_game = false
      end
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
      @spaces = []
      42.times { @spaces.push('-') }
    end

    def update_board(current_player, space_to_move)
      @spaces[space_to_move] = current_player.symbol
    end

    def display_board
      print "\n" + '|'
      @spaces.each_with_index do |_space, index|
        if [6, 13, 20, 27, 34].include? index
          print ' ' + @spaces[index] + ' |' + "\n" \
                ' ---+---+---+---+---+---+---' + "\n" + '|'
        else
          print ' ' + @spaces[index] + ' |'
        end
      end
      print "\n\n"
    end
  end
end

include ConnectFour

Game.new('Player 1', 'Player 2')
