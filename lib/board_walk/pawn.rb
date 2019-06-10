require 'pry'

module BoardWalk

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
    ].freeze

    attr_reader :path

    def initialize(board, initial_x, intial_y)
      @board = board
      raise OutOfBoardError if !@board.within_board?(initial_x, intial_y)
      @start_cell   = @board.cell(initial_x, intial_y)
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
            # binding.pry
            c  = @path.pop
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
      valid_moves(@current_cell)
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
        "(#{cell.x}, #{cell.y})"
      end.join(' -> ')

      puts path_str
      puts "\n"
    end

    def valid_moves(cell)
      possible_moves_from(cell.x, cell.y)
        .map { |x,y| @board.cell(x, y) }
        .select { |cell| !cell.visited? }
    end

    def possible_moves_from(x, y)
      FREEDOM_OF_MOVES.map do |i,j|
        valid_cell_position?(x + i, y + j) ? [x + i, y + j] : nil
      end.compact
    end

    def score(cell)
      valid_moves(cell).length
    end

    def valid_cell_position?(x, y)
      @board.within_board?(x, y)
    end
  end
end