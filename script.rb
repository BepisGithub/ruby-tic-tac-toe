require "pry"

class Board
  def initialize
    @map = [[" "," "," "], [" "," "," "], [" "," "," "]]
  end

  def print_map # HACK
    hash = Hash.new
    @map.each_with_index do |column, index|
      print "|"
      print @map[index][0] # Print the top items
      hash["top"].nil? ? hash["top"] = [@map[index][0]] : hash["top"].push(@map[index][0])
      print "|"
    end
    print "\n"
    @map.each_with_index do |column, index|
      print "|"
      print @map[index][1] # Print the middle item
      hash["mid"].nil? ? hash["mid"] = [@map[index][1]] : hash["mid"].push(@map[index][1])
      print "|"
    end
    print "\n"
    @map.each_with_index do |column, index| 
      print "|"
      print @map[index][2] # Print the bottom item
      hash["bot"].nil? ? hash["bot"] = [@map[index][2]] : hash["bot"].push(@map[index][2])
      print "|"
    end
    print "\n"
    hash
  end

  def draw(row, column, drawing)
    if @map[row][column] == " " # Need to ensure the position being drawn on can't be occupied
      @map[row][column] = drawing
    else
      puts "That spot is occupied, please try again"
      return "Error"
    end
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
    empty_arr
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
    @board = Board.new
  end

  def h_winner? hash
    return hash["top"][0] if hash["top"][0] == hash["top"][1] && hash["top"][0] == hash["top"][2] && hash["top"][0] != " "
    return hash["mid"][0] if hash["mid"][0] == hash["mid"][1] && hash["mid"][0] == hash["mid"][2] && hash["mid"][0] != " "
    return hash["bot"][0] if hash["bot"][0] == hash["bot"][1] && hash["bot"][0] == hash["bot"][2] && hash["bot"][0] != " "

    false
  end

  def v_winner? hash
    3.times do |i|
      return hash["top"][i] if hash["top"][i] == hash["mid"][i] && hash["mid"][i] == hash["bot"][i] && hash["top"][i] != " "
    end
    false
  end

  def d_winner? hash
    return hash["top"][0] if hash["top"][0] == hash["mid"][1] && hash["mid"][1] == hash["bot"][2] && hash["top"][0] != " "
    return hash["top"][2] if hash["top"][2] == hash["mid"][1] && hash["mid"][1] == hash["bot"][0] && hash["top"][2] != " "

    false
  end

  def won?
    hash = @board.print_map
    # TODO: Fix
    return h_winner? hash if h_winner? hash
    return v_winner? hash if v_winner? hash
    return d_winner? hash if d_winner? hash

    false
  end

  def swap_active_states
    @player1.active_player = !@player1.active_player
    @player2.active_player = !@player2.active_player
  end

  def get_choice
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

  def round
    @player1.active_player = true if @player1.active_player == false && @player2.active_player == false
    case @player1.active_player
    when true
      @player2.active_player = false
      choices = position_choices @player1
      return_val = @board.draw(choices[0], choices[1], @player1.drawing)
      error_count = 0
      while return_val == "Error"
        choices = position_choices @player1
        return_val = @board.draw(choices[0], choices[1], @player1.drawing)
        error_count += 1
        if error_count > 2
          rand_choice = @board.empty_spaces
          rand_choice = rand_choice.sample
          return_val = @board.draw(rand_choice[0], rand_choice[1], @player1.drawing)
        end
      end
      swap_active_states
    when false
      @player2.active_player = true
      choices = position_choices @player2
      return_val = @board.draw(choices[0], choices[1], @player2.drawing)
      error_count = 0
      while return_val == "Error"
        choices = position_choices @player2
        return_val = @board.draw(choices[0], choices[1], @player2.drawing)
        error_count += 1
        if error_count > 2
          rand_choice = @board.empty_spaces
          rand_choice = rand_choice.sample
          return_val = @board.draw(rand_choice[0], rand_choice[1], @player2.drawing)
        end
      end
      swap_active_states
    end
  end

  def play
    @board.print_map
    # TODO: Upon a win, print the name of who won
    9.times do
      round
      is_over = won?
      if is_over != false
        if is_over == @player1.drawing
          puts "Good job, #{@player1.name}. You won!"
        else
          puts "Good job, #{@player2.name}. You won!"
        end
        is_over = true
      end
      break if is_over
    end
    puts "That was a good game!"
  end
end
me = Player.new("me")
you = Player.new("you")
game = Game.new(me, you)
# TODO: Keep playing the game until a winner is reached
game.play