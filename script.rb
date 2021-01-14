class Board
  def initialize
    @map = [[], [], []]
  end

  def draw(row, column,drawing)
    # need to ensure the position being drawn on can't be occupied
    if @map[row][column].empty?
      @map[row][column] = drawing
    else
      puts "That spot is occupied, please try again"
    end
  end
end
