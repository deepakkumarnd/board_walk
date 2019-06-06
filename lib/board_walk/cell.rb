module BoardWalk
  class Cell

    attr_reader :x, :y, :visited

    def initialize(x, y)
      @x = x
      @y = y
      @visited = false
    end

    def visited?
      @visited
    end

    def visit!
      @visited = true
    end

    def unvisit!
      @visited = false
    end

    def to_s
      @visited ? ' 1 ' : ' 0 '
    end

    def address
      "(#{x},#{y})"
    end
  end
end