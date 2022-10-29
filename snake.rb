
class Directions
    def self.left
        'left'
    end

    def self.right
        'right'
    end

    def self.up
        'up'
    end

    def self.down
        'down'
    end
end

class Piece
    attr_reader :x, :y
    
    def initialize(x, y)
        @x = x
        @y = y
    end

    def update(x:, y:)
        @x = x
        @y = y
    end

    def self.create_from(snake)
        last = snake.pieces.last
        x = snake.rotate((last&.x || snake.x) - 1)
        y = (last&.y || snake.y)
        Piece.new(x, y)
    end

    def self.clone
        Piece.new(@x, @y)
    end
end

class Snake
    attr_reader :x, :y, :pieces, :board_size, :direction

    def initialize(board_size)
        @direction = Directions.right
        @x = 0
        @y = 0
        @pieces = []
        @board_size = board_size
    end

    def game_over?
        !pieces.find { |p| p.x == @x && p.y == @y }.nil?
    end

    def walk_on(board)
        last_head_x, last_head_y = @x, @y
        if @direction == Directions.right
            @x = rotate(@x + 1)
        elsif @direction == Directions.down
            @y = rotate(@y + 1)
        elsif @direction == Directions.up
            @y = rotate(@y - 1)
        elsif @direction == Directions.left
            @x = rotate(@x - 1)
        end
        
        @pieces = @pieces.map.with_index do |piece, index|
            cloned = piece.clone

            if index == 0
                cloned.update x: last_head_x, y: last_head_y
            else
                previous = @pieces[index - 1]
                cloned.update x: previous.x, y: previous.y
            end

            cloned
        end
    end

    def change_direction(direction)
        if (direction == Directions.left && @direction != Directions.right) ||
           (direction == Directions.right && @direction != Directions.left) ||
           (direction == Directions.up && @direction != Directions.down) ||
           (direction == Directions.down && @direction != Directions.up)
            @direction = direction
        end
    end

    def can_eat(fruit)
        return @x == fruit.x && @y == fruit.y
    end

    def eat(fruit)
        @pieces << Piece.create_from(self)
        fruit.eaten
    end

    def rotate(value)
        if value > board_size
            return 0 
        elsif value < 0
            return board_size
        end
        
        return value
    end

    def debug
        puts "Snake"
        puts "Direction: #{@direction}"
        puts "X: #{@x}, Y: #{@y}"
    end
end