class Camera
    attr_gtk
    attr_accessor :scale, :scene_position

    def initialize args, x: 0, y: 0, scale: 1
        @args = args
        @x = x
        @y = y
        @scale = scale
        @scene_position = {
            x: grid.w/2 - (x * @scale),
            y: grid.h/2 - (y * @scale),
            w: state.world.w * @scale,
            h: state.world.h * @scale,
        }
    end

    def calc x = @x, y = @y
        @scene_position = {
            x: grid.w/2 - (x * @scale),
            y: grid.h/2 - (y * @scale),
            w: state.world.w * @scale,
            h: state.world.h * @scale,
        }

        left_limit = 0
        right_limit = grid.w - state.world.w * @scale
        down_limit = 0        
        if @scene_position.x > left_limit
            @scene_position.merge!(x: left_limit)
        elsif @scene_position.x < (right_limit)
            @scene_position.merge!(x: right_limit)
        end
        if @scene_position.y > down_limit
            @scene_position.merge!(y: down_limit)
        end
    end

    def render
        outputs.sprites << {
            x: @scene_position.x,
            y: @scene_position.y,
            w: @scene_position.w,
            h: @scene_position.h,
            path: :scene
        }
    end
end