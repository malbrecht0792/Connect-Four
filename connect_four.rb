module ConnectFour
  class Game
    def initialize(player1_name, player2_name)
      one_player_or_two?
      @player1 = Player.new(player1_name, 'R')
      @player2 = Player.new(player2_name, 'Y')
      @board = Board.new
      @current_player = @player1
      @continue_game = true
      game_loop
    end

    def one_player_or_two?
      puts 'Would you like to play one player (1) or two player (2)?'
      @num_of_players = gets.chomp.to_i
      unless @num_of_players == 1 || @num_of_players == 2
        puts 'Please enter either 1 or 2'
        one_player_or_two?
      end
    end

    def game_loop
      while @continue_game
        @num_of_players == 1 && @current_player == @player2 ?
                           computer_turn : human_turn
        @board.display_board
        declare_winner if check_for_winner(@current_player)
        check_for_no_winner
        change_players
      end
    end

    def human_turn
      puts "#{@current_player.name}, please select a slot (1-7)."
      @slot_to_move = gets.chomp.to_i
      redo_human_turn unless find_space_to_move
      find_space_to_move
      @board.update_board(@current_player, @space_to_move)
    end

    def redo_human_turn
      puts 'This slot is full! Please select a different slot.'
      @slot_to_move = gets.chomp.to_i
      redo_human_turn unless find_space_to_move
    end

    def computer_turn
      7.times do |column|
        @slot_to_move = column + 1
        next unless find_space_to_move
        @board.update_board(opposite_player, @space_to_move)
        return @board.update_board(@current_player, @space_to_move) if
               check_for_winner(opposite_player)
        @board.undo_move(@space_to_move)
      end
      random_move
    end

    def random_move
      @slot_to_move = rand(1..7)
      random_move unless find_space_to_move
      @board.update_board(@current_player, @space_to_move)
    end

    def opposite_player
      @current_player == @player1 ? @player2 : @player1
    end

    def find_space_to_move
      index_array = [35, 28, 21, 14, 7, 0]

      index_array.each do |index|
        @space_to_move = index + (@slot_to_move - 1)
        return true if @board.spaces[@space_to_move] == '-'
      end
      false
    end

    def check_space_to_move
      @board.spaces[@space_to_move] == '-'
    end

    def change_players
      @current_player = @current_player == @player1 ? @player2 : @player1
    end

    def declare_winner
      puts "#{@current_player.name} wins!"
      @continue_game = false
    end

    def check_for_winner(current_player)
      create_all_winning_spaces_array
      @all_winning_spaces_array.each do |winning_spaces_array|
        all_spaces_true = true
        winning_spaces_array.each do |winning_index|
          all_spaces_true = false unless @board.spaces[winning_index] ==
                                         current_player.symbol
        end
        return true if all_spaces_true
      end
      false
    end

    def create_all_winning_spaces_array
      @all_winning_spaces_array = []
      create_vertical_winning_arrays
      create_horizontal_winning_arrays
      create_left_to_right_diagonal_winning_arrays
      create_right_to_left_diagonal_winning_arrays
    end

    def create_vertical_winning_arrays
      (21..41).to_a.each do |x|
        winning_spaces_array = [x]
        3.times do |y|
          winning_spaces_array.push(x - (7 * (y + 1)))
        end
        @all_winning_spaces_array.push(winning_spaces_array)
      end
    end

    def create_horizontal_winning_arrays
      [0, 7, 14, 21, 28, 35].each do |x|
        4.times do |column|
          winning_spaces_array = [x + column]
          3.times do |y|
            winning_spaces_array.push(x + y + 1 + column)
          end
          @all_winning_spaces_array.push(winning_spaces_array)
        end
      end
    end

    def create_left_to_right_diagonal_winning_arrays
      [0, 7, 14].each do |x|
        4.times do |diagonal|
          winning_spaces_array = [x + diagonal]
          3.times do |y|
            winning_spaces_array.push(x + 8 * (y + 1) + diagonal)
          end
          @all_winning_spaces_array.push(winning_spaces_array)
        end
      end
    end

    def create_right_to_left_diagonal_winning_arrays
      [3, 10, 17].each do |x|
        4.times do |diagonal|
          winning_spaces_array = [x + diagonal]
          3.times do |y|
            winning_spaces_array.push(x + 6 * (y + 1) + diagonal)
          end
          @all_winning_spaces_array.push(winning_spaces_array)
        end
      end
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

  class ComputerPlayer < Player
    
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

    def undo_move(space_to_move)
      @spaces[space_to_move] = '-'
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
