require './snake'
require './board'
require './fruit'
require './os'

require "tty-reader"

reader  = TTY::Reader.new

snake = Snake.new(Board::SIZE)
board = Board.new(snake)
fruit = Fruit.new(board)

reader.on(:keydown) { snake.change_direction(Directions.down) }
reader.on(:keyleft) { snake.change_direction(Directions.left) }
reader.on(:keyup) { snake.change_direction(Directions.up) }
reader.on(:keyright) { snake.change_direction(Directions.right) }

threads = []

points = 0
speed = 1

    loop do
        reader.read_keypress(nonblock: true)
        clear
        snake.walk_on(board)
        if snake.game_over?
            board.draw(fruit: fruit, points: points)
            puts "GAME OVER"
            break
        end
        fruit.recreate
        if snake.can_eat(fruit)
            snake.eat(fruit)
            points += 1
            if speed > 0.1
                speed -= 0.1
            end
        end
        board.draw(fruit: fruit, points: points)
        sleep speed
    end



