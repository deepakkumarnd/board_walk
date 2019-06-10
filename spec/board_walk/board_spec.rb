require 'spec_helper'

module BoardWalk

  RSpec.describe Board do

    subject { Board.new(size = 10) }

    it 'can initialize a board' do
      expect(subject).to be_truthy
    end

    it 'return cell using co-ordinates' do
      expect(subject.cell(0, 0)).to be_a Cell
    end

    it 'raises OutOfBoardError if the co-ordinates are outside of board' do
      expect{ subject.cell(10, 10) }.to raise_error(OutOfBoardError)
    end

    it 'checks if the co-ordinates are within board' do
      expect(subject.within_board?(10, 10)).to be false
    end

    it 'checks if the co-ordinates are within board' do
      expect(subject.within_board?(0, 1)).to be true
    end

    it 'returns the cell count' do
      expect(subject.cell_count).to be 100
    end

    it 'returns false if all the cells are not visited' do
      expect(subject.full?).to be false
    end

    it 'returns true if all the cells are not visited' do
      # mark all cells as visited
      (0...10).each do |r|
        (0...10).each do |c|
          subject.cell(r, c).visit!
        end
      end

      expect(subject.full?).to be true
    end
  end
end