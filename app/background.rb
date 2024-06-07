class Background
    attr_gtk

    def initialize args
        @args = args
        @tile_w = grid.w/3
        @tile_h = grid.h/1.9
    end

    def calc
        @x_offset = state.camera.scene_position.x * 0.1 + state.camera.scale
        @y_offset = state.camera.scene_position.y * 0.1 + state.camera.scale
    end

    def render
        # wall
        outputs.solids << {x: 0, y:0, w: state.world.w, h: state.world.w, r: 230, g: 240, b: 230}

        # bathtiles
        for i in 0..4
            for j in 0..1
                outputs.sprites << {
                    x: i * @tile_w + @x_offset,
                    y: j * @tile_h + @y_offset,
                    w: @tile_w,
                    h: @tile_h,
                    path: "sprites/bathroom_tile.png"
                }
            end
        end

        #bathtube
        outputs[:scene].sprites << {
            x: 0,
            y: 0,
            w: state.world.w,
            h: 1500,
            path: "sprites/bathtube.jpg"
        }
    end
end