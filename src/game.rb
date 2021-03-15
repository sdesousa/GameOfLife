# frozen_string_literal: true

require_relative 'world'

# Game class
class Game
  attr_accessor :world, :seeds

  def initialize(world = World.new, seeds = [])
    @world = world
    @seeds = seeds
    seeds.each do |seed|
      world.cell_grid[seed[0]][seed[1]].alive = true
    end
  end

  def tick!
    next_round_live_cells = []
    next_round_dead_cells = []
    world.cells.each do |cell|
      cell_neighbours_count = world.live_neighbours_around_cell(cell).count
      # Rule 1 and 3
      next_round_dead_cells << cell if cell.alive? && ((cell_neighbours_count < 2) || (cell_neighbours_count > 3))
      # Rule 4
      next_round_live_cells << cell if cell.dead? && (cell_neighbours_count == 3)
    end
    next_round_live_cells.each(&:revive!)
    next_round_dead_cells.each(&:die!)
  end
end
