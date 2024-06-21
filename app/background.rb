class Background
    attr_gtk
    attr_sprite

    def initialize args, x: 0, y: 0
        @args = args
        @x = x
        @y = y
        @w = grid.w / 2
        @h = grid.h / 1.2
        @constant_width = @w
        @constant_height = @h
    end

    def calc

    end

    def render
        # wall
        outputs.sprites << {x: 0, y:0, w: state.world.w, h: state.world.w, r: 200, g: 220, b: 200, path: :pixel}

        # bathtiles
        scale = 0.9
        for i in 0..4
            for j in 0..0
                outputs.sprites << {
                    x: i * @constant_width * scale + @x * 0.05,
                    y: j * @constant_height * scale + @y * 0.1,
                    w: @constant_width * scale,
                    h: @constant_height * scale,
                    path: "sprites/bathroom_tile.png"
                }
            end
        end
    end
end
