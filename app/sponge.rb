class Sponge
  attr_sprite

  def initialize args, x: nil, y: nil
    @args = args
    @x = x
    @y = y
    @w = 300
    @h = 100
    @path = "sprites/redsponge.jpg"
  end

  def render
    @args.outputs << self
  end
end
