class Board
  def initialize
    @map = [[], [], []]
  end
  def draw(row,column)
    unless @map[row,column].empty?
      puts "Sorry, that spot is occupied, please try again"
    end
  end
end
