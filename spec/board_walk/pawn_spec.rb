require 'spec_helper'

module BoardWalk

  RSpec.describe Pawn do

    let(:board) { Board.new(10) }

    subject { Pawn.new(board, 0, 0) }

    it 'can initialize a cell' do
      expect(subject).to be_truthy
    end

    it 'walks on the board and creates a path' do
      expect { subject.walk }.to change(subject.path, :length).by(100)
    end

    # it 'can walk from any position' do
    #   (0...10).each do |r|
    #     (0...10).each do |c|
    #       board = Board.new(10)
    #       pawn  = Pawn.new(board, r, c)
    #       pawn.walk
    #     end
    #   end
    # end
  end
end