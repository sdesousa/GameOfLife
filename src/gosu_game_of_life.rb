# frozen_string_literal: true

require 'gosu'
require_relative 'game'

# Gosu file
class GameOfLife < Gosu::Window
  def initialize(width = 1280, height = 960)
    @width = width
    @height = height
    super width, height, false
    self.caption = 'Game of life'

    # Color
    @background_color = Gosu::Color.new(0xffdedede)
    @alive_color = Gosu::Color.new(0xff121212)
    @dead_color = Gosu::Color.new(0xffededed)

    # Game itself
    @rows = height / 10
    @cols = width / 10
    @row_height = height / @rows
    @col_width = width / @cols
    @world = World.new(@rows, @cols)
    @game = Game.new(@world)
    @game.world.randomly_populate
  end

  def update
    @game.tick!
  end

  def draw
    draw_quad(
      0, 0, @background_color,
      @width, 0, @background_color,
      @width, @height, @background_color,
      0, @height, @background_color
    )
    @game.world.cells.each do |cell|
      cell_color = cell.alive ? @alive_color : @dead_color
      # remove 1 pixel to create visible border for each cell
      draw_quad(
        cell.xval * @col_width + 1, cell.yval * @row_height + 1, cell_color,
        (cell.xval + 1) * @col_width - 1, cell.yval * @row_height + 1, cell_color,
        (cell.xval + 1) * @col_width - 1, (cell.yval + 1) * @row_height - 1, cell_color,
        cell.xval * @col_width + 1, (cell.yval + 1) * @row_height - 1, cell_color
      )
    end
  end

  def needs_cursor?
    true
  end
end
