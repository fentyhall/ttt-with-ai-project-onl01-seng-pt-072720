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
            board.taken?(array[0]+1) && board.cells[array[0]] == board.cells[array[1]] && board.cells[array[1]] == board.cells[array[2]]
        end
    end  

    def draw?
        board.full? && !won? 
    end 

    def over?
        draw? || won?
    end 

    def winner 
        if won?
            board.cells[won?.last]
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
        while !over?
            turn
        end

        if won?
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end  
    end 

    def self.start 
        input = ""

        puts "Do you want to play 0, 1 or 2 player?"
        input = gets.strip
        
        if input == "0"
                game = Game.new(player_1 = Players::Computer.new("X"), player_2 = Players::Computer.new("O"))
        elsif input == "1" 
            puts "Do you want go first? Press Y/N."
            answer = ""
            answer = gets.strip
            if answer == "Y"
                game = Game.new(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"))
            else 
                game = Game.new(player_1 = Players::Computer.new("X"), player_2 = Players::Human.new("O"))
            end 
        else
            game = Game.new(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O")) 
        end 

        game.play
    end 
end 