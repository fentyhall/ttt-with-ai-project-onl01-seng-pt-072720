require 'pry'

class Game 
    attr_accessor :player_1, :player_2, :board
    WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2]]

    def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
        @player_1 = player_1
        @player_2 = player_2 
        @board = board
    end 

    def current_player
        board.turn_count.even? ? player_1 : player_2
    end 

    def won?
        WIN_COMBINATIONS.detect do |array|
            board.cells[array[0]] == board.cells[array[1]] && 
            board.cells[array[1]] == board.cells[array[2]] &&
            board.taken?(array[0])
        end
    end  

    def draw?
        !won? && board.full?
    end 

    def over?
        draw? || won? || board.full?
    end 

    def winner 
        if winning_array = won?
            board.cells[winning_array[0]]
        end  
    end 

    def turn 
        user_input = current_player.move(board)
        if !board.valid_move?(user_input) 
            turn
        else
            board.update(user_input, current_player)
        end 
    end 

    def play 
        turn until over? || draw?
        
        if draw?
            puts "Cat's Game!"
        elsif won?
            puts "Congratulations #{self.winner}!"
        end 
    end 
end 