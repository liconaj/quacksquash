class Bathtube
    attr_gtk
    attr_sprite

    def initialize args, x: 0, y:0, w: 2500, h: 1500
        @args = args
        @x = x
        @y = y
        @h = h
        @w = w
    end

    def render
        width = @w / 4
        for i in 0..3
            outputs.sprites << {
                x: @x + width * i, y: @y, w: width, h: @h, path: "sprites/bathtube-#{i}.png"
            }
        end
    end
end