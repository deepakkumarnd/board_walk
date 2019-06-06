module BoardWalk

  class Board

    def initialize(size = 10, rambler = nil, printer = BoardPrinter)
      @size  = size
      @board = build
      @printer = printer
    end

    def cell(x, y)
      raise BoardWalk::OutOfBoardError if !within_boundary?(x, y)
      @board[x][y]
    end

    def to_s
      @printer.new(@board).to_s
    end

    def within_boundary?(x, y)
      (0...@size).include?(x) && (0...@size).include?(y)
    end

    private

    def build
      Array.new(@size) do |i|
        Array.new(@size) do |j|
          Cell.new(i, j)
        end
      end
    end
  end
end
