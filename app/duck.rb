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
    end

    def handle_movement
        left_limit = 0
        right_limit = state.world.w - @w

        max_speed = 15
        inc_speed = 0.2
        moving = false
        moviny_y = false

        @flip_dir = 0
        if inputs.right
            @dx += inc_speed
            @flip_dir += 1
            moving = true
        end
        if inputs.left
            @dx -= inc_speed
            @flip_dir -= 1
            moving = true
        end
        #if inputs.up
        #    @dy += 5
        #end
        if inputs.down && (in_water || in_surface?)
            @dy -= 7
            moving_y = true
        end

        old_dy = @dy

        # Flotación
        if !in_surface?
            @dy -= @gravity
            if in_water
                if @dy > 0
                    @dy += acc_flotation
                else
                    @dy += 8
                end
            end
        elsif @dy.abs < 10
            @dy *= 0.5
        end

        if @dy.abs > 0.1
            @y += @dy
            @y = @y.clamp(0.03 * state.world.h, state.world.h)
        elsif in_surface?
            stable_level = state.water.level - @deep
            @dy = stable_level - @y
            @y += @dy * 0.01
        end

        @x += @dx
        @dx = @dx.clamp(-max_speed, max_speed)

        if @x < left_limit || @x > right_limit
            @dx = -@dx * 0.6
        end
        @x = @x.clamp(left_limit, right_limit)

        @dx *= (1-@friction)
        #outputs.debug << "dy: #{@dy.abs}"
        #outputs.debug << "level: #{(@y - state.water.level + 30).abs}"
    end

    def calc
        handle_movement
        if @flip_dir != 0
            @flip_horizontally = @flip_dir >= 0
        end
    end

    def render
        outputs.sprites << self
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

    def sgn(n)
        n <=> 0
    end
end
