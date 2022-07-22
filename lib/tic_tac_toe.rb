class TicTacToe
    attr_accessor :board

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]

    def initialize
        @board = [" "," "," "," "," "," "," "," "," "]
    end

    def display_board
       @board.each_slice(3) {|a,b,c| puts " #{a} | #{b} | #{c} -----------"}
    end

    def input_to_index(string)
        string.to_i - 1
    end

    def move(index, token= "X")
        @board[index] = token
    end

    def position_taken? (index)
        @board[index] != " "
    end

    def valid_move?(index)
        @board[index] == " " && index < 9 && index >= 0
        # can be written: index.between?(0,8) && !position_taken?(index) # note the between method syntax asks for (0,8) not (0..8)
    end

    def turn_count
        9 - @board.count(' ')
        # can also be written @board.count {|pos| pos != " "}
    end

    def current_player
        if turn_count % 2 == 0
            'X'
        else
            'O'
        end
        #can also be turn_count.even? "X" : "O"
    end

    def turn
        # pmove = gets.chomp
        # index = self.input_to_index(pmove)
        # if self.valid_move?(index)
        #     self.current_player
        #     self.move(index)
        #     self.display_board
        # else
        #     self.turn
        # end
        #Marc demo:
        puts "Enter your move [1-9]:"
        move_index = input_to_index(gets.strip)
        if valid_move?(move_index)
            move(move_index, current_player)
            display_board
        else
            turn
        end
    end
 #Below is solved during a review with Marc
    def won?
        WIN_COMBINATIONS.any? do |combo|
            if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[0]] == @board[combo[2]]
            return combo
            #if position_taken?(combo[0]) this evaluates to see if there is something ('X or O') is present in the first place.
                #If it is not empty then the rest of the code will execute
            end
        end
    end

    def full?
        @board.all?{|pos| pos != " "}
    end

    def draw?
        full? && !won?
    end

    def over?
        won? || draw?
    end

    def winner
        if combo = won?
            @board[combo[0]]
        end
    end

    def play
        turn until over?
        puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
    end

end
