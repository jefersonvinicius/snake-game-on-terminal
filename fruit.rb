class Fruit
    attr_reader :x, :y
    
    def initialize(board)
        @seconds = 10
        @board = board
        @created_at = Time.now
        set_new_position
    end

    def recreate
        if Time.now - @created_at > @seconds
            set_new_position
            @created_at = Time.now
        end
    end

    def eaten
        if @seconds > 3
            @seconds -= 1
        end
    end

    def to_s
        puts "FRUIT: x=#{@x}, y=#{@y}"
    end

    private

    def set_new_position
        available_positions = @board.available_positions
        position = available_positions.sample
        @x = position[:x]
        @y = position[:y]
    end
end