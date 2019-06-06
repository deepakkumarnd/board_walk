require "board_walk/version"
require "board_walk/cell.rb"
require "board_walk/board.rb"
require "board_walk/board_printer.rb"
require "board_walk/pawn.rb"

module BoardWalk
  class OutOfBoardError < StandardError; end
  class CellAlreadyVistedError < StandardError; end
end