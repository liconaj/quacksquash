class Water
    attr_gtk
    attr_sprite

    def initialize(args, h: grid.h/2)
        @args = args
        
        @x = 0
        @y = 0
        @h = h
        @w = state.world.w
        @r = 0
        @g = 150
        @b = 255
        @a = 30
        @path = "sprites/water_shades.png"
    end

    def render
        outputs.primitives << {x: @x, y:@y, w:@w, h:@h, r:@r, g:@g, b:@b, a:@a}.solid!
        outputs.sprites << {x: @x, y:@y, w:@w, h:@h, a:130, path:@path}
    end
end