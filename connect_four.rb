# contains intro, game rules and the messages for if there's a winner
module Game
  def intro
    puts "Connect Four is a 2-player board game, in which the players take turns
dropping colored tokens into a seven-column, six-row grid. The pieces fall straight down,
occupying the lowest available space within the column.\n\n"
    puts "The objective of the game is to be the first to form a horizontal, vertical
or diagonal line of four of one's own tokens.\n\n"
  end

  def winner_message(player)
    puts "#{player.name.upcase} WINS!!"
  end

  def draw
    puts 'Draw'
  end
end

# class for the game board
class GameBoard
  include Game
  attr_accessor :board

  def initialize
    @board = Array.new(6) { Array.new(7) { "\e[37m \u26AA" } }
    intro
  end

  def display_board
    label = ' 1  2  3  4  5  6  7'
    puts "#{board[0][0]}#{board[0][1]}#{board[0][2]}#{board[0][3]}#{board[0][4]}#{board[0][5]}#{board[0][6]}"
    puts "#{board[1][0]}#{board[1][1]}#{board[1][2]}#{board[1][3]}#{board[1][4]}#{board[1][5]}#{board[1][6]}"
    puts "#{board[2][0]}#{board[2][1]}#{board[2][2]}#{board[2][3]}#{board[2][4]}#{board[2][5]}#{board[2][6]}"
    puts "#{board[3][0]}#{board[3][1]}#{board[3][2]}#{board[3][3]}#{board[3][4]}#{board[3][5]}#{board[3][6]}"
    puts "#{board[4][0]}#{board[4][1]}#{board[4][2]}#{board[4][3]}#{board[4][4]}#{board[4][5]}#{board[4][6]}"
    puts "#{board[5][0]}#{board[5][1]}#{board[5][2]}#{board[5][3]}#{board[5][4]}#{board[5][5]}#{board[5][6]}"
    puts label
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
      puts 'input error'
    end
    column - 1
  end

  def verify_input(number)
    return number if number.between?(1, 7)
  end

  def winner?(player)
    # horiontal check
    board.each do |row|
      row.each_index do |j|
        if row[j] == player.token && row[j + 1] == player.token && row[j + 2] == player.token && row[j + 3] == player.token
          return true
        end
      end
    end

    # vertical check
    board.each_with_index do |row, i|
      row.each_index do |j|
        break if i > 2
        if board[i][j] == player.token && board[i + 1][j] == player.token && board[i + 2][j] == player.token && board[i + 3][j] == player.token
          return true
        end
      end
    end

    # diagonal check
    board.each_with_index do |row, i|
      row.each_index do |j|
        break if i > 2

        if j < 4 # left to right diagonal
          if board[i][j] == player.token && board[i + 1][j + 1] == player.token && board[i + 2][j + 2] == player.token && board[i + 3][j + 3] == player.token
            return true
          end
        elsif j > 2 # right to left diagonal
          if board[i][j] == player.token && board[i + 1][j - 1] == player.token && board[i + 2][j - 2] == player.token && board[i + 3][j - 3] == player.token
            return true
          end
        end
      end
    end
    false
  end

  def play_game(p1, p2)
    p1.turn = true
    display_board
    until winner?(p1) || winner?(p2)
      if p1.turn
        column = take_input(p1)
        place_token(p1, column)
        display_board
        p1.turn = false
      else
        column = take_input(p2)
        place_token(p2, column)
        display_board
        p1.turn = true
      end
      break if board.all? { |row| row.none? { |token| token == "\e[37m \u26AA" } }

      winner_message(p1) if winner?(p1)
      winner_message(p2) if winner?(p2)
    end
    draw if !winner?(p1) && !winner?(p2)
  end

  private

  def player_input(player)
    puts "#{player.name}: Choose a column to place token"
    gets.chomp.to_i
  end
end

# class for the players
class Player
  attr_reader :name, :token
  attr_accessor :turn
  
  @@players = []

  def initialize
    @name = get_name
    @token = get_token
  end

  def get_name
    if empty?
      puts 'Player 1: What is your name?'
    else
      puts 'Player 2: What is your name?'
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

game = GameBoard.new
p1 = Player.new
p2 = Player.new
game.play_game(p1, p2)
