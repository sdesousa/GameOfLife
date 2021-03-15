# frozen_string_literal: true

require 'rspec'
require_relative '../src/world'

# World spec file

describe 'World' do
  let!(:cell) { Cell.new(1, 1) }
  context 'World' do
    subject { World.new }
    it 'should create a new world object' do
      expect(subject.is_a?(World)).to be true
    end
    it 'should respond to proper methods' do
      expect(subject).to respond_to(:rows)
      expect(subject).to respond_to(:cols)
      expect(subject).to respond_to(:cell_grid)
      expect(subject).to respond_to(:live_neighbours_around_cell)
      expect(subject).to respond_to(:cells)
      expect(subject).to respond_to(:randomly_populate)
      expect(subject).to respond_to(:live_cells)
    end
    it 'should create proper cell grid on initialization' do
      expect(subject.cell_grid.is_a?(Array)).to be true
      subject.cell_grid.each do |row|
        expect(row.is_a?(Array)).to be true
        row.each do |col|
          expect(col.is_a?(Cell)).to be true
        end
      end
    end
    it 'should add all cells to cells array' do
      expect(subject.cells.count).to equal(9)
    end
    it 'should detect a neighbour to the North' do
      subject.cell_grid[cell.yval - 1][cell.xval].alive = true
      expect(subject.live_neighbours_around_cell(cell).count).to equal(1)
    end
    it 'should detect a neighbour to the North-East' do
      subject.cell_grid[cell.yval - 1][cell.xval + 1].alive = true
      expect(subject.live_neighbours_around_cell(cell).count).to equal(1)
    end
    it 'should detect a neighbour to the East' do
      subject.cell_grid[cell.yval][cell.xval + 1].alive = true
      expect(subject.live_neighbours_around_cell(cell).count).to equal(1)
    end
    it 'should detect a neighbour to the South-East' do
      subject.cell_grid[cell.yval + 1][cell.xval + 1].alive = true
      expect(subject.live_neighbours_around_cell(cell).count).to equal(1)
    end
    it 'should detect a neighbour to the South' do
      subject.cell_grid[cell.yval + 1][cell.xval].alive = true
      expect(subject.live_neighbours_around_cell(cell).count).to equal(1)
    end
    it 'should detect a neighbour to the South-West' do
      subject.cell_grid[cell.yval + 1][cell.xval - 1].alive = true
      expect(subject.live_neighbours_around_cell(cell).count).to equal(1)
    end
    it 'should detect a neighbour to the West' do
      subject.cell_grid[cell.yval][cell.xval - 1].alive = true
      expect(subject.live_neighbours_around_cell(cell).count).to equal(1)
    end
    it 'should detect a neighbour to the North-West' do
      subject.cell_grid[cell.yval - 1][cell.xval - 1].alive = true
      expect(subject.live_neighbours_around_cell(cell).count).to equal(1)
    end
    it 'should detect a neighbour when cell is on the border' do
      subject.cell_grid[2][2].alive = true
      subject.cell_grid[1][2].alive = true
      expect(subject.live_neighbours_around_cell(subject.cell_grid[1][2]).count).to equal(1)
    end
    it 'should randomly populate the world' do
      expect(subject.live_cells.count).to equal(0)
      subject.randomly_populate
      expect(subject.live_cells.count).to_not equal(0)
    end
  end
end
