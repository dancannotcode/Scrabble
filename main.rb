require_relative 'UpdateGame.rb'
require_relative 'CheckTurn.rb'
require_relative 'Players.rb'
class Game
  def self.main(args)
    game = UpdateGame.new
    move = CheckTurn.new
    game_in_progress(game, move)
  end

  def self.game_in_progress(game, move)
    # Builds game and asks for the number of players
    max_score = 5
    game.create_board
    player_count = 0
    until (2..4).cover?(player_count)
      puts "How many players [2-4]: "
      player_count = gets.chomp.to_i
    end

    # Creates player objects based on user input
    list = Array.new(player_count) { Players.new }
    list.each(&:create_hand)

    no_winner = true
    #game will continue until there is a winner
    while no_winner
      list.each do |player|
        break unless no_winner

        game.display_board
        puts "Choose what column you would like to play[0-14]: "
        player.row = gets.chomp.to_i
        puts "Choose what row you would like to play[0-14]: "
        player.column = gets.chomp.to_i
        legal_move = true
        #will keep asking for letters until legal move is made
        while legal_move
          puts "What letter(s) would you like to play?"
          player.display_hand
          print "> "
          player.letters = gets.chomp
          puts "Would you like to play Horizontally or Vertically? H or V: "
          player.direction = gets.chomp.upcase
          legal_move = move.illegal_move?(player, game)
        end
        #updates score
        game.update_score(player, player.letters)
        #checks to see if winner is declared
        list.each_with_index do |player_score, index|
          puts "Player #{index + 1} score: #{player_score.score}"
          if player_score.score >= max_score
            game_over(list, index)
            no_winner = false
            break
          end
        end
      end
    end
  end
  #congratulates winned
  def self.game_over(list, player_count)
    puts "Congratulations Player #{player_count + 1}!"
  end
end
#call main
Game.main([])
