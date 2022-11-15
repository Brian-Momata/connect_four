# class for the game board
class GameBoard
  attr_accessor :board

  def initialize
    @board = Array.new(6) { Array.new(7) { "\u26AA"} }
  end
  
  def display_board
    puts "#{board[0][0]}#{board[0][1]}#{board[0][2]}#{board[0][3]}#{board[0][4]}#{board[0][5]}#{board[0][6]}"
    puts "#{board[1][0]}#{board[1][1]}#{board[1][2]}#{board[1][3]}#{board[1][4]}#{board[1][5]}#{board[1][6]}"
    puts "#{board[2][0]}#{board[2][1]}#{board[2][2]}#{board[2][3]}#{board[2][4]}#{board[2][5]}#{board[2][6]}"
    puts "#{board[3][0]}#{board[3][1]}#{board[3][2]}#{board[3][3]}#{board[3][4]}#{board[3][5]}#{board[3][6]}"
    puts "#{board[4][0]}#{board[4][1]}#{board[4][2]}#{board[4][3]}#{board[4][4]}#{board[4][5]}#{board[4][6]}"
    puts "#{board[5][0]}#{board[5][1]}#{board[5][2]}#{board[5][3]}#{board[5][4]}#{board[5][5]}#{board[5][6]}"
  end
end