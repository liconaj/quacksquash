class Duck
  attr_gtk
  attr_sprite

  def initialize args, x: 0, y: 0
      @args = args
      @x = x
      @y = y
      @w = 128
      @h = 128
      @flip_horizontally = true
      @path = "sprites/rubberduck.png"

      @dx = 0
      @dy = 0
      @friction = 0.005
      @last_x = x
      @gravity = 1.5
      @acc_y = 0
      @flip_dir = 0
      @deep = 15
      @max_speed = 15
      @inc_speed = 0.2
      @left_limit = 0
      @right_limit = state.world.w - @w
      @boosted = false
      @boosted_water = false
  end

  def calc
      handle_input
      update_position
      update_velocity
      clamp_position
      if @flip_dir != 0
          @flip_horizontally = @flip_dir >= 0
      end
  end

  def render
      outputs.sprites << self
  end

  def update_velocity
    if !in_surface?
        @dy -= @gravity
        apply_bouyancy if in_water
    elsif @dy.abs < 10
        @dy *= 0.5
    end

    @dx = @dx.clamp(-@max_speed, @max_speed)

    if @x < @left_limit || @x > @right_limit
        @dx = -@dx * 0.6
        outputs.debug << "COLLISION!"
    end

    @dx *= (1-@friction)
end

  def update_position
    @x += @dx
    if @dy.abs > 0.1
        @y += @dy
    elsif in_surface?
        stable_level = state.water.level - @deep
        @dy = stable_level - @y
        @y += @dy * 0.01
    end
  end

  def clamp_position
    @x = @x.clamp(@left_limit, @right_limit)
    @y = @y.clamp(0.03 * state.world.h, state.world.h)
  end

  def handle_input
    @flip_dir = 0
    if inputs.right
      @dx += @inc_speed
      @flip_dir += 1
    end
    if inputs.left
      @dx -= @inc_speed
      @flip_dir -= 1
    end
    if inputs.down && (in_water || in_surface?)
      @dy -= 7
    end
    if inputs.up && !@boosted && !@boosted_water && (in_water || in_surface?)
        if @y < state.water.level - @deep - @h
            @dy += 5
        else
            @dy = 22
        end
        @boosted = true
        @boosted_water = true
    else
        @boosted = false
    end
    if !in_water || in_surface?
        @boosted_water = false
    end
  end

  def in_water
      @y <= state.water.level - @deep
  end

  def in_surface?
      (@y - state.water.level + @deep).abs <= 5
  end

  def acc_flotation
      acc_1 = 2.5
      acc_2 = 2
      h_1 = 0
      h_2 = state.water.level
      d_acc = acc_2 - acc_1
      d_h = h_2 - h_1
      m = d_acc / d_h
      h = @y
      m * (h - h_1) + acc_1
  end

  def apply_bouyancy
    if @dy > 0
        @dy += acc_flotation
    else
        @dy += 8
    end
  end

  def sgn(n)
      n <=> 0
  end
end
