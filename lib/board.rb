class Board 
    attr_accessor :cells 

    def reset!
        self.cells = Array.new(9, " ")
    end 

    def initialize 
        reset!
    end 

    def display 
        puts " #{self.cells[0]} | #{self.cells[1]} | #{self.cells[2]} "
        puts "-----------"
        puts " #{self.cells[3]} | #{self.cells[4]} | #{self.cells[5]} "
        puts "-----------"
        puts " #{self.cells[6]} | #{self.cells[7]} | #{self.cells[8]} "
    end 

    def position(user_input)
        num = user_input.to_i - 1
        cells[num]
    end 

    def full?
        cells.all?{|token| token == "X" || token == "O"}
    end 

    def turn_count 
        cell_count = []
        cells.each do |cell| 
            if cell == "X" || cell == "O"
                cell_count << cell 
            end 
        end 
        cell_count.size 
    end 

    def taken?(user_input)
        position(user_input) == "X" || position(user_input) == "O"
    end 

    def valid_move?(user_input)
        !taken?(user_input) && user_input.between?("1", "9")
    end 

    def update(user_input, player)
        valid_move?(user_input) 
        num = user_input.to_i - 1
        cells[num] = player.token 
    end 
end 