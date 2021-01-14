class Board
  def initialize
    @map = [[], [], []]
  end

  def draw(row, column, drawing)
    # need to ensure the position being drawn on can't be occupied
    if @map[row][column].empty?
      @map[row][column] = drawing
    else
      puts "That spot is occupied, please try again"
    end
  end
end

class Player
  attr_reader :drawing

  @@number_of_players = 0
  def initialize(name)
    @name = name
    @has_won = false
    @active_player = false
    (@@number_of_players % 2).zero? ? @drawing = "X" : @drawing = "O"
    @@number_of_players += 1
  end
end

class Game
  def initialize(player1, player2, board)
    @player1 = player1
    @player2 = player2
    @board = board
  end

  def play
    @player1.active_player = true if player1.active_player == false && player2.active_player == false
    case @player1.active_player
    when true
      @player2.active_player = false
      puts "Which row would you like to draw on? 1 or 2 or 3"
      row_choice = gets.chomp until choice.is_a? Integer
      puts "Which column would you like to draw on? 1 or 2 or 3"
      column_choice = gets.chomp until choice.is_a? Integer
    when false

    end
  end
end