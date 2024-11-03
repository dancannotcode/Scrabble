require 'set'

class CheckTurn
  attr_accessor :dictionary

  def initialize
    @dictionary = Set.new
  end

  def illegal_move?(player, game)
    # Load dictionary from file
    dictionary = Set.new
    File.foreach("LegalWords.txt") { |line| dictionary << line.chomp }

    letter = player.letters

    # Check if player has appropriate letters
    unless game.update_hand(player)
      puts "Illegal move! You don't have the appropriate letter(s). Try again."
      return true
    end

    # Check if the move is out of bounds
    if player.row + letter.length >= 15 || player.column + letter.length >= 15
      puts "Illegal move! Out of bounds. Try again."
      return true
    end

    # Check if the word exists in the dictionary
    word = letter.upcase
    unless dictionary.include?(word)
      puts "Illegal move! Word '#{word}' does not exist. Try again."
      return true
    end

    # Check if the word can be placed on the board
    increment = 1
    row = player.row
    col = player.column
    #if there is no previous letter on the board, the word can be placed
    if game.board[row][col] == "0"
      game.board[row][col] = letter[0]
      word = letter[0]
      (1...letter.length).each do |length|
        if player.direction.upcase == "H"
          word << game.board[row + length][col] unless game.board[row + length][col] == "0"
          word << letter[increment]
          increment += 1
        elsif player.direction.upcase == "V"
          word << game.board[row][col + length] unless game.board[row][col + length] == "0"
          word << letter[increment]
          increment += 1
        end
      end
    else
      #appends the letters to the previous word then continues
      word << game.board[row][col]
      (1..letter.length).each do |length|
        if player.direction.upcase == "H"#if it runs in into horizontial letter appends to it
          if game.board[row + length][col] != "0"
            word << game.board[row + length][col]
          else
            game.board[row + length][col] = letter[length - 1]
            word << letter[length - 1]
            player.hand[length] = ""
          end
        elsif player.direction.upcase == "V"#if it runs in into vertical letter appends to it
          if game.board[row][col + length] != "0"
            word << game.board[row][col + length]
          else
            game.board[row][col + length] = letter[length - 1]
            word << letter[length - 1]
            player.hand[length] = ""
          end
        end
      end
    end

    word.upcase!
    # Check if the word is a valid word and updatehand
    if dictionary.include?(word)
      puts word
      game.update_board(player, word)
      game.create_board
      game.display_board
      game.update_hand(player)
      player.create_hand
      return false
    end

    puts "Illegal move! Word '#{word}' does not exist. Try again."
    true
  end

end
