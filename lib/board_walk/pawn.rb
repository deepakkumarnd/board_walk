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
      raise OutOfBoardError if !@board.within_boundary?(initial_x, intial_y)
      @start_cell   = @board.cell(initial_x, intial_y)
      @path = []
    end

    def walk
      @current_cell = @start_cell
      @current_cell.visit!
      @path.push(@current_cell)

      loop do
        move = find_best_move

        if move.nil?
          if @path.length == @board.cell_count
            print_path
            break
          else
            @path.pop
            # c.unvisit! if c
            @current_cell = @path.pop
            if @current_cell.nil?
              puts "Can't find full path starting with #{@start_cell.address}"
              break
            end
          end
        else
          jump_to(move)
        end
      end
    end

    def find_best_move
      valid_moves(@current_cell)
        .sort_by { |cell| score(cell) }
        .first
    end

    def jump_to(cell)
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
      @board.within_boundary?(x, y)
    end
  end
end