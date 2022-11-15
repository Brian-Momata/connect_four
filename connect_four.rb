# class for the game board
class GameBoard
  attr_accessor :board

  def initialize
    @board = Array.new(6) { Array.new(7) { "\u26AA"} }
  end
  
end