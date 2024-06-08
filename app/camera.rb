class Camera
    attr_gtk
    attr_accessor :viewport

    def initialize args, x: 0, y: 0, zoom: 1
        @args = args
        @x = x
        @y = y
        @zoom = zoom
        @offset_x = (grid.w - state.world.w) / 2
        @offset_y = (grid.h - state.world.h) / 2
    end

    def viewport
        {
            x: @offset_x,
            y: @offset_y,
            scale:  @zoom
        }
    end

    def render_in_world objects
        objects.each do |object|
            translated_object = object.dup 
            translated_object.x = object.x * viewport.scale - viewport.x
            translated_object.y = object.y * viewport.scale - viewport.y
            translated_object.w = object.w * viewport.scale
            translated_object.h = object.h * viewport.scale
            translated_object.render
        end
    end

    def calc x: nil, y: nil
        left_limit = 0
        right_limit = (state.world.w * @zoom - grid.w)
        down_limit = 0
        upper_limit = (state.world.h * @zoom - grid.h)
        @offset_x = (x * @zoom) - grid.w/2
        @offset_y = (y * @zoom) - grid.h/2
        @offset_x = @offset_x.clamp(left_limit, right_limit > left_limit ? right_limit : left_limit)
        @offset_y = @offset_y.clamp(down_limit, upper_limit > down_limit ? upper_limit : down_limit)
    end
end