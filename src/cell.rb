# frozen_string_literal: true

# Cell Class
class Cell
  attr_accessor :alive, :xval, :yval

  def initialize(xval = 0, yval = 0)
    @alive = false
    @xval = xval
    @yval = yval
  end

  def alive?
    alive
  end

  def dead?
    !alive
  end

  def die!
    @alive = false
  end

  def revive!
    @alive = true
  end
end
