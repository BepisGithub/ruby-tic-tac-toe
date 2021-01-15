class Board
  def initialize
    @map = [[" "," "," "], [" "," "," "], [" "," "," "]]
  end

  def print_map # HACK
    hash = Hash.new # TODO: convert the values appended to the hash into an array of sorts in order to check specific points in the grid
    @map.each_with_index do |column, index|
      print "|"
      print @map[index][0] # Print the top items
      hash["top"].nil? ? hash["top"] = @map[index][0] : hash["top"] += @map[index][0]
      print "|"
    end
    print "\n"
    @map.each_with_index do |column, index|
      print "|"
      print @map[index][1] # Print the middle item
      hash["mid"].nil? ? hash["mid"] = @map[index][1] : hash["mid"] += @map[index][1]
      print "|"
    end
    print "\n"
    @map.each_with_index do |column, index| 
      print "|"
      print @map[index][2] # Print the bottom item
      hash["bot"].nil? ? hash["bot"] = @map[index][2] : hash["bot"] += @map[index][2]
      print "|"
    end
    print "\n"
    p hash
  end

  def draw(row, column, drawing)
    # Need to ensure the position being drawn on can't be occupied
    if @map[row][column] == " "
      @map[row][column] = drawing
    else
      puts "That spot is occupied, please try again"
      return "Error"
    end
    print_map
  end

  def empty_spaces
    empty_arr = []
    @map.each_with_index do |column, index_column|
      column.each_with_index do |row, index_row|
        empty_arr.push([index_column, index_row]) if @map[index_column][index_row].include?(" ")
      end
    end
    if empty_arr.empty?
      puts "No empty spots"
      return "Error"
    end
    p empty_arr
  end
end

class Player
  attr_reader :drawing, :name
  attr_accessor :has_won, :active_player

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
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board = Board.new()
  end

  # TODO
  def h_winner? hash

  end

  def v_winner? hash

  end

  def d_winner? hash

  end

  def won? hash
    h_winner? hash
    v_winner? hash
    d_winner? hash
  end
  # END TODO

  def swap_active_states
    @player1.active_player = !@player1.active_player
    @player2.active_player = !@player2.active_player
  end

  def get_choice # HACK
    choice = gets.chomp.to_i until choice.is_a? Integer
    until choice <= 3 && choice >= 1
      puts "Out of range input, try again"
      choice = ""
      choice = gets.chomp.to_i until choice.is_a? Integer
    end
    choice - 1
  end

  def position_choices player
    puts "Which row would you like to draw your symbol #{player.drawing} on, #{player.name}? 1 or 2 or 3"
    row_choice = get_choice
    puts "Which column would you like to draw your symbol #{player.drawing} on, #{player.name}? 1 or 2 or 3"
    column_choice = get_choice
    [column_choice, row_choice]
  end

  def play
    @player1.active_player = true if @player1.active_player == false && @player2.active_player == false
    case @player1.active_player
    when true
      @player2.active_player = false
      choices = position_choices @player1
      return_val = @board.draw(choices[0], choices[1], @player1.drawing)
      p return_val
      error_count = 0
      while return_val=="Error"
        choices = position_choices @player1
        return_val = @board.draw(choices[0], choices[1], @player1.drawing) # TODO: Randomly place the users choice after 5 failed attempts
        error_count += 1
        if error_count > 5
          @board.empty_spaces
        end
      end
      # TODO: check if the player has won
      swap_active_states
    when false
      @player2.active_player = true
      choices = position_choices @player2
      return_val = @board.draw(choices[0], choices[1], @player2.drawing) # TODO: Randomly place the users choice after 5 failed attempts
      p return_val
      error_count = 0
      while return_val=="Error"
        choices = position_choices @player2
        return_val = @board.draw(choices[0], choices[1], @player2.drawing)
        error_count += 1
        if error_count > 5
          @board.empty_spaces
        end
      end
      # TODO: check if the player has won
      swap_active_states
    end
    # TODO: End the game if a player has won
  end
end
me = Player.new("me")
you = Player.new("you")
game = Game.new(me, you)
5.times { game.play }
# TODO: Keep playing the game until a winner is reached or the max number of attempts have been reached (9)