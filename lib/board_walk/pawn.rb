require 'pry'

module BoardWalk

  Move = Struct.new(:xdiff, :ydiff)

  class Pawn

    FREEDOM_OF_MOVES = [
      [-3, 0],
      [-2, 2],
      [0, 3],
      [2, 2],
      [3, 0],
      [2, -2],
      [0, -3],
      [-2, -2]
    ].map { |xdiff, ydiff| Move.new(xdiff, ydiff) }
     .freeze

    attr_reader :path

    def initialize(board, initial_x, intial_y)
      @board = board
      raise OutOfBoardError if !@board.within_board?(initial_x, intial_y)
      @start_cell = @board.cell(initial_x, intial_y)
      @path = []
    end

    def walk
      @current_cell = @start_cell
      @current_cell.visit!
      @path.push(@current_cell)

      loop do
        next_cell = find_best_move

        if next_cell.nil?
          if all_cells_visited?
            print_path
            break
          else
            c = @path.pop
            c.unvisit! if c
            @current_cell = @path.pop
            if @current_cell.nil?
              puts "Can't find full path starting with #{@start_cell.address}"
              break
            end
          end
        else
          visit(next_cell)
        end
      end
    end

    def all_cells_visited?
      (@path.length == @board.cell_count) && @board.full?
    end

    def find_best_move
      valid_moves_from(@current_cell)
        .min_by { |cell| score(cell) }
    end

    def visit(cell)
      raise CellAlreadyVistedError if cell.visited?
      raise CellAlreadyVistedError if @path.include?(cell)
      @current_cell = cell
      @current_cell.visit!
      @path.push(@current_cell)
    end

    def print_path
      puts "\nFound path"
      path_str = @path.map do |cell|
        cell.address
      end.join(' -> ')

      puts path_str
      puts "\n"
    end

    def valid_moves_from(cell)
      possible_moves_from(cell.x, cell.y)
        .map { |x,y| @board.cell(x, y) }
        .select { |cell| !cell.visited? }
    end

    def possible_moves_from(x, y)
      FREEDOM_OF_MOVES.map do |move|
        [x + move.xdiff, y + move.ydiff] if valid_cell_position?(x + move.xdiff, y + move.ydiff)
      end.compact
    end

    def score(cell)
      valid_moves_from(cell).length
    end

    def valid_cell_position?(x, y)
      @board.within_board?(x, y)
    end
  end
end