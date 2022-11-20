# class for the game board
class GameBoard
  attr_accessor :board

  def initialize
    @board = Array.new(6) { Array.new(7) { "\e[37m \u26AA"} }
  end
  
  def display_board
    puts "#{board[0][0]}#{board[0][1]}#{board[0][2]}#{board[0][3]}#{board[0][4]}#{board[0][5]}#{board[0][6]}"
    puts "#{board[1][0]}#{board[1][1]}#{board[1][2]}#{board[1][3]}#{board[1][4]}#{board[1][5]}#{board[1][6]}"
    puts "#{board[2][0]}#{board[2][1]}#{board[2][2]}#{board[2][3]}#{board[2][4]}#{board[2][5]}#{board[2][6]}"
    puts "#{board[3][0]}#{board[3][1]}#{board[3][2]}#{board[3][3]}#{board[3][4]}#{board[3][5]}#{board[3][6]}"
    puts "#{board[4][0]}#{board[4][1]}#{board[4][2]}#{board[4][3]}#{board[4][4]}#{board[4][5]}#{board[4][6]}"
    puts "#{board[5][0]}#{board[5][1]}#{board[5][2]}#{board[5][3]}#{board[5][4]}#{board[5][5]}#{board[5][6]}"
  end

  def place_token(player, column)
    i = board.length - 1

    while i >= 0
      if board[i][column] == "\e[37m \u26AA"
        @board[i][column] = player.token
        break
      end
      i -= 1
    end
  end

  def take_input(player)
    column = ''
    loop do
      column = verify_input(player_input(player))
      break if column
     
      puts "input error"
    end
    column - 1
  end

  def verify_input(number)
    return number if number.between?(1, 7)
  end
  end

  private
  def player_input(player)
    puts "#{player.name} Choose a column to place token"
    gets.chomp.to_i
  end
end

#class for the players
class Player 
  attr_reader :name, :token, :turn
  
  @@players = []

  def initialize
    @name = get_name
    @token = get_token
  end

  def get_name
    if empty?
      puts "Player 1: What is your name?"
    else
      puts "Player 2: What is your name?"
    end
    player_name = gets.chomp
    @@players << player_name
    player_name
  end

  def get_token
    return "\e[33m \u26AB" if size == 1
    "\e[31m \u26AB"
  end

  private
  def empty?
    @@players.empty?
  end

  def size
    @@players.size
  end
end