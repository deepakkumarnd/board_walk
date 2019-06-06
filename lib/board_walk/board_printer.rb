module BoardWalk

  class BoardPrinter

    def initialize(board)
      @board = board
    end

    def to_s
      paragraph = @board.map do |raw|
        line = raw.map do |cell|
          cell.to_s
        end.join('|')

        ['|', line, '|', "\n", " - "*14].join
      end.join("\n")

      [" - "*14, "\n", paragraph].join
    end
  end
end