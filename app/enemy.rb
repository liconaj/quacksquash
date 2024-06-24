class Enemy
  attr_sprite

  def initialize args, player
    @args = args
    @player = player
    @tick_index = 0
    @x = 0
    @y = 0
    @w = 150
    @h = 150
    @flip_horizontally = true
    @path = "sprites/enemy.png"
    @follow = false
  end

  def play
    @follow = true
  end

  def calc
    return if !@follow

    @x = @player.positions[@tick_index].x
    @y = @player.positions[@tick_index].y
    @flip_horizontally = @player.positions[@tick_index].last
    @tick_index += 1
  end

  def render
    return if !@follow
    @args.outputs.sprites << self
  end
end
