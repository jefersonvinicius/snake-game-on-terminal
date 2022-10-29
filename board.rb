class Board
    SIZE = 10
    HEAD = 'O'
    BODY = 'o' 
    FRUIT = 'x'
    BOARD = '-'

    def initialize(snake)
        @snake = snake
    end

    def draw(fruit:, points:)
        pieces_positions = map_pieces_positions

        puts "POINTS: #{points}"
        (0..SIZE).each do |col|
            (0..SIZE).each do |row|
                if @snake.x == row && @snake.y == col
                    print HEAD
                elsif pieces_positions.dig(row, col) == true
                    print BODY
                elsif fruit.x == row && fruit.y == col
                    print FRUIT
                else
                    print BOARD
                end
            end    
            print "\n"
        end
    end

    def available_positions
        pieces_positions = map_pieces_positions
        positions = []
        (0..SIZE).each do |col|
            (0..SIZE).each do |row|  
                if pieces_positions.dig(row, col).nil?
                    positions << {x: row, y: col}
                end
            end    
        end

        positions
    end

    private
    
    def map_pieces_positions
        hash = @snake.pieces.each_with_object({}) do |obj, hash|
            if hash[obj.x].nil?
                hash[obj.x] = {}
            end
            hash[obj.x][obj.y] = true
        end

        if (hash[@snake.x].nil?)
            hash[@snake.x] = {}
        end
        hash[@snake.x][@snake.y] = true

        hash
    end
end