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
  @@number_of_players = 0
  def initialize(name)
    @name = name
    @has_won = false
    @@number_of_players += 1
    (@@number_of_players % 2).zero? ? @drawing = "X" : @drawing = "O"
  end
end