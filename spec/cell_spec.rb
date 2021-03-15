# frozen_string_literal: true

require 'rspec'
require_relative '../src/cell'

# Cell spec file

describe 'Cell' do
  context 'Cell' do
    subject { Cell.new }
    it 'should create a new cell object' do
      expect(subject.is_a?(Cell)).to be true
    end
    it 'should  respond to proper methods' do
      expect(subject).to respond_to(:alive)
      expect(subject).to respond_to(:xval)
      expect(subject).to respond_to(:yval)
      expect(subject).to respond_to(:alive?)
      expect(subject).to respond_to(:die!)
      expect(subject).to respond_to(:revive!)
    end
    it 'should initialize properly' do
      expect(subject.alive).to be false
      expect(subject.xval).to equal(0)
      expect(subject.yval).to equal(0)
    end
  end
end
