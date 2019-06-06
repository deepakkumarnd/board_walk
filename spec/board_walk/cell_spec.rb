require 'spec_helper'

module BoardWalk

  RSpec.describe Cell do

    subject { Cell.new(0, 0) }

    it 'can initialize a cell' do
      expect(subject).to be_truthy
    end

    it 'is not visited by default' do
      expect(subject.visited?).to be false
    end

    it 'can be visited' do
      subject.visit!
      expect(subject.visited?).to be true
    end

    it 'can be unvisited' do
      subject.unvisit!
      expect(subject.visited?).to be false
    end

    it 'prints an unvisited cell' do
      expect(subject.to_s).to eq(" 0 ")
    end

    it 'prints a visited cell' do
      subject.visit!
      expect(subject.to_s).to eq(" 1 ")
    end

    it 'prints cell address in (x, y) form' do
      subject.visit!
      expect(subject.address).to eq("(0,0)")
    end
  end
end