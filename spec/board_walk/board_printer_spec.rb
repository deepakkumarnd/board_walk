require 'spec_helper'

module BoardWalk

  RSpec.describe BoardPrinter do

    subject { BoardPrinter.new([[]]) }

    it 'can initialize a board printer' do
      expect(subject).to be_truthy
    end
  end
end