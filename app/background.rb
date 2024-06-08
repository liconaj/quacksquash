class Background
    attr_gtk
    attr_sprite

    def initialize args, x: 0, y: 0
        @args = args
        @x = x
        @y = y
        @w = grid.w / 2
        @h = grid.h / 1.2
    end

    def calc
        
    end

    def render
        # wall
        outputs.solids << {x: 0, y:0, w: state.world.w, h: state.world.w, r: 200, g: 220, b: 200}

        # bathtiles
        for i in 0..4
            for j in 0..0
                outputs.sprites << {
                    x: i * @w + @x * 0.3,
                    y: j * @h + @y * 0.4,
                    w: @w,
                    h: @h,
                    path: "sprites/bathroom_tile.png"
                }
            end
        end
    end
end