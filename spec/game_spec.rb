# frozen_string_literal: true

require 'rspec'
require_relative '../src/game'

# spec file

describe 'Game' do
  let!(:world) { World.new(3, 3) }
  context 'Game' do
    subject { Game.new }
    it 'should create a new game object' do
      expect(subject.is_a?(Game)).to be true
    end
    it 'should respond to proper methods' do
      expect(subject).to respond_to(:world)
      expect(subject).to respond_to(:seeds)
    end
    it 'should initialize properly' do
      expect(subject.world.is_a?(World)).to be true
      expect(subject.seeds.is_a?(Array)).to be true
    end
    it 'should plant seeds properly' do
      game = Game.new(world, [[1, 2], [0, 2]])
      expect(game.world.cell_grid[1][2]).to be_alive
      expect(game.world.cell_grid[0][2]).to be_alive
    end
  end
  context 'rules' do
    let!(:game) { Game.new }
    context 'Rule 1: Any live cell with fewer than two live neighbours dies, as if by underpopulation.' do
      it 'should kill a live cell with no neighbours' do
        game.world.cell_grid[1][1].alive = true
        expect(game.world.cell_grid[1][1]).to be_alive
        game.tick!
        expect(game.world.cell_grid[1][1]).to be_dead
      end
      it 'should kill a live cell with 1 live neighbour' do
        game = Game.new(world, [[1, 0], [2, 0]])
        game.tick!
        expect(world.cell_grid[1][0]).to be_dead
        expect(world.cell_grid[2][0]).to be_dead
      end
      it "doesn't kill live cell with 2 neighbours" do
        game = Game.new(world, [[0, 1], [1, 1], [2, 1]])
        game.tick!
        expect(world.cell_grid[1][1]).to be_alive
      end
    end
    context 'Rule 2: Any live cell with two or three live neighbours lives on to the next generation' do
      it 'should keep alive cell with 2 neighbours to next generation' do
        game = Game.new(world, [[0, 1], [1, 1], [2, 1]])
        expect(world.live_neighbours_around_cell(world.cell_grid[1][1]).count).to equal(2)
        game.tick!
        expect(world.cell_grid[0][1]).to be_dead
        expect(world.cell_grid[1][1]).to be_alive
        expect(world.cell_grid[2][1]).to be_dead
      end
      it 'should keep alive cell with 3 neighbours to next generation' do
        game = Game.new(world, [[0, 1], [1, 1], [2, 1], [2, 2]])
        expect(world.live_neighbours_around_cell(world.cell_grid[1][1]).count).to equal(3)
        game.tick!
        expect(world.cell_grid[0][1]).to be_dead
        expect(world.cell_grid[1][1]).to be_alive
        expect(world.cell_grid[2][1]).to be_alive
        expect(world.cell_grid[2][2]).to be_alive
      end
    end
    context 'Rule 3: Any live cell with more than three live neighbours dies, as if by overpopulation' do
      it 'should kill live cell with more than 3 live neighbours' do
        game = Game.new(world, [[0, 1], [1, 1], [2, 1], [2, 2], [1, 2]])
        expect(world.live_neighbours_around_cell(world.cell_grid[1][1]).count).to equal(4)
        game.tick!
        expect(world.cell_grid[0][1]).to be_alive
        expect(world.cell_grid[1][1]).to be_dead
        expect(world.cell_grid[2][1]).to be_alive
        expect(world.cell_grid[2][2]).to be_alive
        expect(world.cell_grid[1][2]).to be_dead
      end
    end
    context 'Rule 4: Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction' do
      it 'should revives dead cell with 3 neighbours' do
        game = Game.new(world, [[0, 1], [1, 1], [2, 1]])
        expect(world.live_neighbours_around_cell(world.cell_grid[1][0]).count).to equal(3)
        game.tick!
        expect(world.cell_grid[1][0]).to be_alive
        expect(world.cell_grid[1][2]).to be_alive
      end
    end
  end
end
