
class UpdateGame
  ROWS = 15
  COLUMNS = 15

  attr_accessor :board
  #Creates the board
  def initialize
    @board = Array.new(ROWS) { Array.new(COLUMNS) }
  end

  def create_board
    ROWS.times do |row|
      COLUMNS.times do |col|
        @board[row][col] = "0" if @board[row][col].nil?
      end
    end
  end
  #shows the board
  def display_board
    COLUMNS.times do |col|
      ROWS.times { |row| print "#{@board[row][col]}    " }
      puts
    end
  end
  #places the letters on the board
  def update_board(player, word)
    row = player.row
    col = player.column
    word.chars.each_with_index do |letter, i|
      if player.direction && player.direction.upcase == "H"
        @board[row + i][col] = letter
      elsif player.direction && player.direction.upcase == "V"
        @board[row][col + i] = letter
      end
    end
  end
  #removes and replaces letters in players hand
  def update_hand(player)
    letters = player.letters
    letters.chars.each do |character|
      character = character.upcase
      found = false
      player.hand.each_with_index do |hand_character, hand_index|
        next if hand_character.nil?

        if character == hand_character
          player.hand[hand_index] = nil
          found = true
          break
        end
      end
      return false unless found
    end
    true
  end
  #players score is updated according to the letters played
  def update_score(player, word)
    word.upcase.chars.each do |letter|
      case letter
      when 'D', 'G'
        player.score += 2
      when 'B', 'C', 'M', 'P'
        player.score += 3
      when 'F', 'H', 'V', 'W', 'Y'
        player.score += 4
      when 'K'
        player.score += 5
      when 'J', 'X'
        player.score += 8
      when 'Q', 'Z'
        player.score += 10
      else
        player.score += 1
      end
    end
  end
end
