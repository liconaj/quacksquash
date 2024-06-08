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
        @friction = 0.01
        @last_x = x
        @acc = 0
        @flip_dir = 0
    end

    def handle_movement
        left_limit = 0.03 * state.world.w
        right_limit = 0.94 * state.world.w

        max_speed = 10
        inc_speed = 0.2
        
        @dy = 0
        @flip_dir = 0
        if inputs.right
            if @x > right_limit - 200
                @dx += inc_speed * 0.1
            else
                @dx += inc_speed
            end
            @flip_dir += 1
        end
        if inputs.left
            if @x < left_limit + 200
                @dx -= inc_speed * 0.1
            else
                @dx -= inc_speed
            end
            @flip_dir -= 1
        end
        if inputs.up
            @dy += 5
        end
        if inputs.down
            @dy -= 5
        end

        @dx = @dx.clamp(-max_speed, max_speed)
        @x += @dx
        @y += @dy

        if @x < left_limit || @x > right_limit
            @dx = -@dx * 0.4
        end
        @x = @x.clamp(left_limit, right_limit)
        @y = @y.clamp(0.03 * state.world.h, state.world.h)

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
end