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

  end
end