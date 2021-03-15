# frozen_string_literal: true

require_relative 'cell'

# World class
class World
  attr_accessor :rows, :cols, :cell_grid, :cells

  def initialize(rows = 3, cols = 3)
    @rows = rows
    @cols = cols
    @cells = []
    @cell_grid = Array.new(rows) do |row|
      Array.new(cols) do |col|
        cell = Cell.new(col, row)
        cells << cell
        cell
      end
    end
  end

  def live_neighbours_around_cell(cell)
    live_neighbours = []
    left_right = [0, cell.xval - 1].max..[cell.xval + 1, cols - 1].min
    top_bottom = [0, cell.yval - 1].max..[cell.yval + 1, rows - 1].min
    left_right.each do |x|
      top_bottom.each do |y|
        live_neighbours << cell_grid[y][x] if cell_grid[y][x].alive? && ((x != cell.xval) || (y != cell.yval))
      end
    end
    live_neighbours
  end

  def live_cells
    cells.select(&:alive)
  end

  def randomly_populate
    cells.each do |cell|
      cell.alive = [true, false].sample
    end
  end
end
