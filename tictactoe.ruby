class TicTacToe
  WIN_COMBINATIONS = [
    [0,1,2], # top row
    [3,4,5], # middle row
    [6,7,8], # bottom row
    [0,3,6], # left column
    [1,4,7], # center column
    [2,5,8], # right column
    [0,4,8], # left diagonal
    [6,4,2]  # right diagonal
  ]

  def initialize
    @board = Array.new(9, ' ')
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, player)
    @board[index] = player
  end

  def position_taken?(index)
    @board[index] != " "
  end

  def valid_move?(index)
    index.between?(0, 8) && !position_taken?(index)
  end

  def turn_count
    @board.count { |space| space == "X" || space == "O" }
  end

  def current_player
    turn_count.even? ? "X" : "O"
  end

  def play
    until over?
      turn
    end

    if won?
      puts "Congratulations #{current_player}!"
    elsif draw?
      puts "Cat's game!"
    end
  end

  def turn
    puts "Please enter 1-9:"
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(index)
      move(index, current_player)
    else
      turn
    end
    display_board
  end

  def won?
    WIN_COMBINATIONS.any? do |combo|
      positions = @board.values_at(*combo)
      positions.all? { |position| position == "X" } || positions.all? { |position| position == "O" }
    end
  end

  def full?
    @board.all? { |position| position != " " }
  end

  def draw?
    full? && !won?
  end

  def over?
    won? || draw?
  end

  def winner
    if winning_combo = won?
      @board[winning_combo.first]
    end
  end
end

# Initialize and start the game
game = TicTacToe.new
game.play

